// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JTNetworkModule",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JTNetworkModule",
            targets: ["JTNetworkModule"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "JTNetworkModule"),
        .testTarget(
            name: "JTNetworkModule_Unit_Tests",
            dependencies: ["JTNetworkModule"]),
        .testTarget(
            name: "JTNetworkModule_End_To_End_Tests",
            dependencies: ["JTNetworkModule"]),
    ]
)
