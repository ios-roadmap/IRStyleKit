// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IRStyleKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "IRStyleKit",
            targets: ["IRStyleKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ios-roadmap/ircore.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "IRStyleKit",
            dependencies: [
                .product(name: "IRCore", package: "ircore"),
            ]
        ),
    ]
)
