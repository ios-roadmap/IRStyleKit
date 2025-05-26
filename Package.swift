// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IRStyleKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "IRStyleKit",
            targets: ["IRStyleKit"]),
    ],
    dependencies: [
        .package(name: "IRCommon", path: "../IRCommon"),
        .package(name: "IRCore", path: "../IRCore"),
        .package(name: "IRResources", path: "../IRResources"),
        
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.1.3"),
    ],
    targets: [
        .target(
            name: "IRStyleKit",
            dependencies: [
                "IRCommon",
                "IRCore",
                "IRResources",

                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
            ],
            path: "IRStyleKit"
        )
    ]
)
