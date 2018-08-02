# UTF8String

Just some shims, hacks, etc., so that portions of the standard library can be built via an SPM package.

## Set up

### 1. Install a recent trunk development toolchain

Download and install one from swift.org/download.

This package was developed using the Xcode-10 beta.

### 2. Clone the repos

This package assumes you have a swift checkout with utf-8 string support in a neighboring folder `utf8-swift`, and are using the `milseman/utf8string` branch. To set that up from a top-level directory:

```sh
  git clone git@github.com:milseman/UTF8String.git
  mkdir utf8-swift
  cd utf8-swift
  git clone --single-branch -b utf8string git@github.com:milseman/swift.git
  cd ../UTF8String
  open UTF8String.xcodeproj
```


## Using as a Full-Fledged Standard Library

All code can be built 2-ways, through this package or as part of a real standard library build. For the latter, build the branch with compatible LLVM and Clang hashes.

That branch is tied to late-July 2018 hashes from when it branched off. To automatically set all the branches to the correct state run this command (note that "swift" will be checked out to whatever is at the top of milseman/utf8string):

    cd UTF8String && utils/update-checkout-to-utf8string-shas

## Commentary

This general technique should apply to anyone wanting to work on portions of the stdlib as though it were a standalone SPM package. It does have some tradeoffs though:

### Downsides

- Anything present is shadowed
  - Literals will get their default type from the toolchain and not the shadow.
- Limited by access control when using anything not shadowed

### Upsides

- Toolchain definitions still available
  - Test that compare behavior differences between shadowed functionality and the toolchain's

