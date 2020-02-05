class BaidupcsGo < Formula
  desc "The terminal utility for Baidu Network Disk"
  homepage "https://github.com/iikira/BaiduPCS-Go"
  version "3.6.1"
  url "https://github.com/iikira/BaiduPCS-Go/archive/#{version}.tar.gz"
  sha256 "07e1d802e6b49425a53b883c354d8b753de55f7005ac8c7b27cd8396db0447da"

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "07c1610dfb0beb9a3ee4ba68209fef1440dd6a7cac848e5cde41d2cb3379335a" => :catalina
  #   sha256 "3b5d79236674f7c222bda94ef560e74414dea2fb219c2e6acc63c66b662c722a" => :mojave
  #   sha256 "4965b6a261743ad46b7625803f0f0efba3a80d4af8dd81a66b77dc7c148951f1" => :high_sierra
  # end

  # stable do
  #   version "3.6.1"
  #   url "https://github.com/iikira/BaiduPCS-Go/releases/download/v#{version}/BaiduPCS-Go-v#{version}-darwin-osx-amd64.zip"
  #   sha256 "bb5989cdeaeea721932eee97fbadc721c8c1500f0916157c619eac80f235ae35"
  # end

  head do
    url "https://github.com/iikira/BaiduPCS-Go.git", :using => :git, :branch => 'master'
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/iikira").mkpath
    ln_s buildpath, buildpath/"src/github.com/iikira/BaiduPCS-Go"
    system "go", "get", "github.com/iikira/BaiduPCS-Go"
    # system "go", "build", "-o", bin/"baidupcs-go"

    bin.install "bin/BaiduPCS-Go"

    bin.install_symlink "BaiduPCS-Go" => "baidupcs"
  end

  test do
    # system bin/"baidupcs-go", "run", "touch", "test.txt"
    # assert_predicate testpath/"test.txt", :exist?
    output = shell_output("#{bin}/BaiduPCS-Go --version 2>&1")
    assert_match "BaiduPCS-Go version #{version}-devel", output
    system "#{bin}/baidupcs", "--version"
    system "BaiduPCS-Go", "--version"
    system "baidupcs", "--version"
  end
end
