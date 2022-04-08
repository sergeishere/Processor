// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Processor",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "Processor",
            targets: ["Processor"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Processor",
            dependencies: []),
        .testTarget(
            name: "ProcessorTests",
            dependencies: ["Processor"]),
    ]
)
