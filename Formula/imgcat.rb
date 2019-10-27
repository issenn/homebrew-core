require 'formula'

class Imgcat < Formula
  desc 'Display images in your iTerm2 terminal Windows.'
  # homepage 'https://www.iterm2.com/images.html'
  homepage 'https://www.iterm2.com/documentation-images.html'
  # url 'https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat'
  url 'https://www.iterm2.com/utilities/imgcat'
  version '0.0.1'
  sha256 'b8fd783db29dbdd8a84beabbc251544dcc26bafad3b20c9ff32db7e8c7cd2869'

  def install
    bin.install 'imgcat'
  end

end
