// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UTF8String",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "UTF8String",
      targets: ["UTF8String"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
//    .package(url: "git@github.com:milseman/StdlibShims.git", .branch("master"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "UTF8String"
//      dependencies: ["StdlibShims"]
    ),
    .testTarget(
      name: "UTF8StringTests"
//      dependencies: ["UTF8String"]
    ),
  ]
)
