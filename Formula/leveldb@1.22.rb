class LeveldbAT122 < Formula
  desc "Key-value storage library with ordered mapping"
  homepage "https://github.com/google/leveldb/"
  url "https://github.com/google/leveldb/archive/1.22.tar.gz"
  sha256 "55423cac9e3306f4a9502c738a001e4a339d1a38ffbee7572d4a07d5d63949b2"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "gperftools"
  depends_on "snappy"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
      system "make", "install"
      bin.install "leveldbutil"

      system "make", "clean"
      system "cmake", "..", *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
      system "make"
      lib.install "libleveldb.a"
    end
  end

  test do
    assert_match "dump files", shell_output("#{bin}/leveldbutil 2>&1", 1)
  end
end
