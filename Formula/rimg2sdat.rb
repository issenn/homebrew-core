class Rimg2sdat < Formula
    desc "Tool to convert raw images(EXT4 filesystem) to sparse Android data (system.new.dat)"
    homepage "https://github.com/jazchen/rimg2sdat"
    url "https://raw.githubusercontent.com/jazchen/rimg2sdat/master/rimg2sdat.py"
    version "0.0.1"
    sha256 "4d698ab2bc6339f23ae690d79c897433801d4f1b064ae1a964f0fdb9a986e816"
  
    def install
      bin.install "rimg2sdat.py"
    end
  end