class CurlMax < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.63.0.tar.bz2"
  mirror "http://curl.mirror.anstey.ca/curl-7.63.0.tar.bz2"
  sha256 "9bab7ed4ecff77020a312d84cc5fb7eb02d58419d218f267477a724a17fd8dd8"

  bottle do
    cellar :any
    # sha256 "84c070944750b1ab555478769569326a5af985de9242b64a4f59041cd51b4a3b" => :mojave
    # sha256 "d3cac8f1bd6593c58358e9e7c3b187182f9b7be5ed1edd4f372c4afb83eea052" => :high_sierra
    # sha256 "075a6eb711c03a18bd6a5a39ac537224e2cd3acec447b358015239d925547f72" => :sierra
  end

  head do
    url "https://github.com/curl/curl.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only :provided_by_macos

  option "with-rtmpdump", "Build with RTMP support"
  option "with-libssh2", "Build with scp and sftp support"
  option "with-c-ares", "Build with C-Ares async DNS support"
  option "with-gssapi", "Build with GSSAPI/Kerberos authentication support."
  option "with-libmetalink", "Build with libmetalink support."
  option "with-nghttp2", "Build with HTTP/2 support (requires OpenSSL)"
  option "with-libidn2", "Build with IDN support"

  deprecated_option "with-rtmp" => "with-rtmpdump"
  deprecated_option "with-ssh" => "with-libssh2"
  deprecated_option "with-ares" => "with-c-ares"

  # HTTP/2 support requires OpenSSL 1.0.2+ or LibreSSL 2.1.3+ for ALPN Support
  # which is currently not supported by Secure Transport (DarwinSSL).
  if MacOS.version < :mountain_lion  # || build.with?("nghttp2")
    depends_on "openssl"
  else
    option "with-openssl@1.1", "Build with OpenSSL 1.1 instead of Secure Transport"
    depends_on "openssl@1.1" => :optional
    option "with-openssl", "Build with OpenSSL 1.0 instead of Secure Transport"
    depends_on "openssl" => :optional
  end

  depends_on "pkg-config" => :build
  depends_on "cunit" => :build
  depends_on "c-ares" => :optional
  depends_on "libmetalink" => :optional
  depends_on "libssh2" => :optional
  depends_on "nghttp2" => :recommended
  depends_on "rtmpdump" => :optional
  depends_on "libidn2" => :recommended
  # depends_on "krb5"
  # depends_on "brotli" => :recommended
  # depends_on "openldap"
  # depends_on "libev"
  # depends_on "jansson"

  def install
    system "./buildconf" if build.head?

    # Allow to build on Lion, lowering from the upstream setting of 10.8
    ENV.append_to_cflags "-mmacosx-version-min=10.7" if MacOS.version <= :lion

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=taki-kun-#{prefix}
    ]

    # cURL has a new firm desire to find ssl with PKG_CONFIG_PATH instead of using
    # "--with-ssl" any more. "when possible, set the PKG_CONFIG_PATH environment
    # variable instead of using this option". Multi-SSL choice breaks w/o using it.
    if MacOS.version < :mountain_lion || build.with?("openssl") || build.with?("openssl@1.1") || build.with?("nghttp2")
      if build.with?("openssl@1.1")
        openssl = "openssl@1.1"
      else
        openssl = "openssl"
      end
      ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula[openssl].opt_lib}/pkgconfig"
      args << "--with-ssl=#{Formula[openssl].opt_prefix}"
      args << "--with-ca-bundle=#{etc}/#{openssl}/cert.pem"
      args << "--with-ca-path=#{etc}/#{openssl}/certs"
    else
      args << "--with-darwinssl"
      args << "--without-ca-bundle"
      args << "--without-ca-path"
    end

    args << (build.with?("libssh2") ? "--with-libssh2" : "--without-libssh2")
    args << (build.with?("libmetalink") ? "--with-libmetalink" : "--without-libmetalink")
    args << (build.with?("rtmpdump") ? "--with-librtmp" : "--without-librtmp")
    args << (build.with?("libidn2") ? "--with-libidn2" : "--without-libidn2")
    args << (build.with?("gssapi") ? "--with-gssapi" : "--without-gssapi")
    # args << (build.with?("spnego") ? "--with-spnego" : "--without-spnego")

    if build.with? "c-ares"
      args << "--enable-ares=#{Formula["c-ares"].opt_prefix}"
    else
      args << "--disable-ares"
    end

    system "./configure", *args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "lib/mk-ca-bundle.pl"

    # curl-config --libs outputs all libs, even private ones.
    # Is a known issue upstream but can cause problems when
    # third-parties try to link against curl. Can be fixed
    # with an inreplace until upstream find a happy solution.
    # inreplace bin/"curl-config",
    #           "${CURLLIBDIR}-lcurl -lcares",
    #           "${CURLLIBDIR} -L#{vendor}/lib -lcurl -lcares"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system "#{bin}/curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?

    # Test IDN support.
    if build.with? "libidn2"
      ENV.delete("LC_CTYPE")
      ENV["LANG"] = "en_US.UTF-8"
      system "#{bin}/curl", "-L", "www.räksmörgås.se", "-o", "index.html"
      assert_predicate testpath/"index.html", :exist?, "Failed to download IDN example site!"
      assert_match "www.xn--rksmrgs-5wao1o.se", File.read("index.html")
    end
  end
end
