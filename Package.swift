// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGD",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftGD",
            targets: ["SwiftGD"]),
    ],
    dependencies: [],
    targets: [
        .systemLibrary(name: "gd", pkgConfig: "gdlib", providers: [.apt(["libgd-dev"]), .brew(["gd"])]),
        .target(name: "SwiftGD", dependencies: ["gd"]),
        .testTarget(name: "SwiftGDTests", dependencies: ["SwiftGD"])
    ]
)
