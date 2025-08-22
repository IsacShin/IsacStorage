// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IsacStorage",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "IsacStorage",
            targets: ["IsacStorage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IsacShin/IsacFoundation.git", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "IsacStorage"
            ,dependencies: ["IsacFoundation"]),

    ]
)
