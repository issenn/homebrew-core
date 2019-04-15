class Fernflower < Formula
  homepage "https://github.com/fesh0r/fernflower"

  head do
    url "https://github.com/fesh0r/fernflower.git"
    depends_on "gradle" => :build
  end

  depends_on :java => "1.7+"

  def install
    system "gradle", "build"
    libexec.install Dir["build/libs/fernflower.jar"]
    bin.write_jar_script libexec/"fernflower.jar", "fernflower"
  end

  test do
    system "#{bin}/fernflower"
  end
end
