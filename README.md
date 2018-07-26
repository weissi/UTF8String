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

That branch is tied to late-July 2018 hashes from when it branched off (note that "swift" should have whatever is at the top of milseman/utf8string):

                "compiler-rt": "eb14686023b616db2835eab7709743f60fe832a9", 
                "llvm": "a4d539e482ca76290f3db6b775203ae230b34d42", 
                "swift-xcode-playground-support": "f2e299a37eb6531918b6c9ce7f555b54d68d92d4", 
                "swift-corelibs-foundation": "ba812f3b3617d43d495c153c7a34f04498880faf", 
                "clang": "773ac0251a7ea94c0b58d96353d4210a7eb2aeef", 
                "llbuild": "7ab27b6a5e4988392bcc056fd432c3f9652e68bd", 
                "cmark": "d875488a6a95d5487b7c675f79a8dafef210a65f", 
                "lldb": "873a338b5d8b74ed504c5e02e52d6972fe9bc513", 
                "swiftpm": "5449a25666b8757b5a926b70eb25e372f06c547a", 
                "swift-corelibs-xctest": "11b22e5ed8d6ffc2734810ae6d3b56160092745b", 
                "ninja": "253e94c1fa511704baeb61cf69995bbf09ba435e", 
                "swift-integration-tests": "e882c92e1f063f5971f11c4163414fd75356f521", 
                "swift": milseman/utf8string,
                "swift-corelibs-libdispatch": "5f49e8bd1403757da08a685cea9c276ccdd09b75"

## Commentary

This general technique should apply to anyone wanting to work on portions of the stdlib as though it were a standalone SPM package. It does have some tradeoffs though:

### Downsides

- Anything present is shadowed
  - Literals will get their default type from the toolchain and not the shadow.
- Limited by access control when using anything not shadowed

### Upsides

- Toolchain definitions still available
  - Test that compare behavior differences between shadowed functionality and the toolchain's

