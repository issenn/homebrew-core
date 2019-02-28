class Sdat2img < Formula
    desc "Convert sparse Android data image (.dat) into filesystem ext4 image (.img)"
    homepage "https://github.com/xpirt/sdat2img"
    url "https://raw.githubusercontent.com/xpirt/sdat2img/master/sdat2img.py"
    version "0.0.1"
    sha256 "35c39baf6f7e700e4cbebf70b86d602e312e3146e58ec1e8b08c1baf046edeb9"
  
    def install
      bin.install "sdat2img.py"
      mv bin/"sdat2img.py", bin/"sdat2img"
    end
  end