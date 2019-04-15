class ClassDump < Formula
  desc "(Fork) Utility for examining the Objective-C segment of Mach-O files"
  homepage "http://stevenygard.com/projects/class-dump/"

  stable do
    url "https://github.com/schwa/class-dump/archive/3.6.tar.gz"
    sha256 "55fb5e0478a637f89b1b133ecaf6ec969262f086a87a5c8a1a082b169aee219c"
  end

  depends_on :xcode => :build

  def install
    xcodebuild "-configuration", "Release", "SYMROOT=build", "PREFIX=#{prefix}", "ONLY_ACTIVE_ARCH=YES"
    bin.install "build/Release/class-dump"
  end
end
