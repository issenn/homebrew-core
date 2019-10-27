# homebrew-core

[![Build Status](https://travis-ci.com/issenn/homebrew-core.svg?branch=master)](https://travis-ci.com/issenn/homebrew-core)

Various often experimental or unstable cryptographic-related formulae.

## How do I install these formulae?

The normal homebrew tap and install routine will work
Just `brew tap issenn/homebrew-core` and then `brew install <formula>`.

    $ brew tap colinstein/imgcat
    $ brew install imgcat

You can also install via URL:

```
brew install https://raw.githubusercontent.com/issenn/homebrew-core/master/Formula/<formula>.rb
```

## What projects are included:

### class-dump

Generate Objective-C headers from Mach-O files.

`brew install class-dump`

My [fork](https://github.com/schwa/class-dump) (forked from Steve Nygard's [original repo](https://github.com/nygard/class-dump)). Includes patches necessary to work [without OpenSSL](https://github.com/nygard/class-dump/pull/58)
).

Unfortately class-dump broken on Mac OS X 10.11 and was subsequently moved to homebrew's boneyard. This fork fixes 10.11 compatibility (see [this issue](https://github.com/nygard/class-dump/pull/58)) and may include other outstanding pull requests from Steves original repository.

### curl-max

### imgcat

Display images in your iTerm2 terminal Windows.

#### Description
Display an image in your terminal in `cat`-like way. This requires a recent
version of iTerm2 2.9 Beta in order to function. The `imgcat` script is taken
from the [iTerm 2 repository](https://github.com/gnachman/iTerm2/blob/master/tests/imgcat)
and was released under the GPLv2 Copyleft license. This tap exists just to make
it easier to install.

#### Usage
Treat it like a [useless use of cat](http://porkmail.org/era/unix/award.html#cat)

    $ imgcat foo.jpg

For more information on [Images in iTerm2](https://www.iterm2.com/documentation-images.html)
see their feature page.

### confd

### rimg2sdat

### sdat2img

Troubleshooting:
--------------------------------

If you encounter any errors, feel free to file an issue. A `brew gist-logs <formula>` is often handy. Thanks!

## License
See [LICENSE](./LICENSE) for a copy of the BSD 2 Clause License.
