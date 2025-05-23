// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IRStyleKitLibrary",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "IRStyleKitLibrary",
            targets: ["IRStyleKitLibrary"]),
    ],
    dependencies: [
        .package(name: "IRCore", path: "../../IRCore"),
        .package(name: "IRResources", path: "../../IRResources"),
        
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.1.3"),
    ],
    targets: [
        .target(
            name: "IRStyleKitLibrary",
            dependencies: [
                "IRCore",
                "IRResources",
                
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
            ]
        ),

    ]
)
