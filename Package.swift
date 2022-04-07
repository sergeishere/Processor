// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DynamicProcess",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "DynamicProcess",
            targets: ["DynamicProcess"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DynamicProcess",
            dependencies: []),
        .testTarget(
            name: "DynamicProcessTests",
            dependencies: ["DynamicProcess"]),
    ]
)
