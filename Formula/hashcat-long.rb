class HashcatLong < Formula
  desc "World's fastest and most advanced password recovery utility"
  homepage "https://hashcat.net/hashcat/"
  url "https://hashcat.net/files/hashcat-5.1.0.tar.gz"
  sha256 "283beaa68e1eab41de080a58bb92349c8e47a2bb1b93d10f36ea30f418f1e338"
  version_scheme 1
  # head "https://github.com/hashcat/hashcat.git"
  head "https://github.com/hashcat/hashcat.git", :using => :git, :branch => 'master'

  # bottle do
  #   sha256 "4ad387b50b7aeb56058d3e83fbac70d6f750d4636d255f94534526d9d6885b56" => :catalina
  #   sha256 "b33b3b59b9e65fa33b35ade1cd7b39a334198701dd47ea89d3f717de1c3cdad5" => :mojave
  #   sha256 "3de92d3e2fbe15dcfeda31f900bd58fe92469f7e04d68b09a1e9db4e01d87781" => :high_sierra
  #   sha256 "383cf945f9263a4e777db23bcee81ab4175e4679930c657628b76d3430e8bd94" => :sierra
  # end

  keg_only :provided_by_macos

  depends_on "gnu-sed" => :build

  # Upstream could not fix OpenCL issue on Mavericks.
  # https://github.com/hashcat/hashcat/issues/366
  # https://github.com/Homebrew/homebrew-core/pull/4395
  depends_on :macos => :yosemite

  def install
    if build.head?
      files = ["src/modules/module_11600.c"]
    elsif build.stable?
      files = ["src/interface.c"]
    else
      files = []
    end
    files.select { |ff| File.file?(ff) }.each do |s|
      system "grep 327528 #{s}"
    end
    inreplace files.select { |ff| File.file?(ff) }.each do |s|
      s.gsub! /(\s*if\s\(data_len\s\>\s)327528(\)\sreturn\s\(PARSER_SALT_VALUE\)\;)/, "\\11637640\\2"
    end
    files.select { |ff| File.file?(ff) }.each do |s|
      system "grep 1637640 #{s}"
    end

    system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
    system "make", "install", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
  end

  test do
    cp_r pkgshare.children, testpath
    cp bin/"hashcat", testpath
    system testpath/"hashcat --benchmark -m 0"
  end
end
