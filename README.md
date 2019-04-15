# homebrew-core

[![Build Status](https://travis-ci.org/Taki-Kun/homebrew-core.svg?branch=master)](https://travis-ci.org/Taki-Kun/homebrew-core)

Various often experimental or unstable cryptographic-related formulae.

## How do I install these formulae?

Just `brew tap Taki-Kun/homebrew-core` and then `brew install <formula>`.

You can also install via URL:

```
brew install https://raw.githubusercontent.com/Taki-Kun/homebrew-core/master/Formula/<formula>.rb
```

## What projects are included:

### class-dump

Generate Objective-C headers from Mach-O files.

`brew install class-dump`

My [fork](https://github.com/schwa/class-dump) (forked from Steve Nygard's [original repo](https://github.com/nygard/class-dump)). Includes patches necessary to work [without OpenSSL](https://github.com/nygard/class-dump/pull/58)
).

Unfortately class-dump broken on Mac OS X 10.11 and was subsequently moved to homebrew's boneyard. This fork fixes 10.11 compatibility (see [this issue](https://github.com/nygard/class-dump/pull/58)) and may include other outstanding pull requests from Steves original repository.

Troubleshooting:
--------------------------------

If you encounter any errors, feel free to file an issue. A `brew gist-logs <formula>` is often handy. Thanks!

# Usage
