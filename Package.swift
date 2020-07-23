// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SwiftGD",
    products: [
        .library(
            name: "SwiftGD",
            targets: ["SwiftGD"]
        )
    ],
    dependencies: [
    .package(url: "https://github.com/twostraws/Cgd.git", from: "0.3.0")],
    targets: [
        .systemLibrary(name: "gd", pkgConfig: "gdlib", providers: [.apt(["libgd-dev"]), .brew(["gd"])]),
        .target(name: "SwiftGD", dependencies: ["gd"]),
        .testTarget(name: "SwiftGDTests", dependencies: ["SwiftGD"])
    ]
)
