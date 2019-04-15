class Fernflower < Formula
  desc "First actually working analytical decompiler for Java"
  homepage "https://github.com/fesh0r/fernflower"
  url "https://github.com/fesh0r/fernflower.git", :using => :git
  version "0.1.0"

  depends_on :java => "1.7+"

  def install
    system "./gradlew", "build"
    libexec.install "build/libs/fernflower.jar"
    bin.write_jar_script libexec/"fernflower.jar", "fernflower"
  end

  test do
    system "#{bin}/fernflower"
  end
end
