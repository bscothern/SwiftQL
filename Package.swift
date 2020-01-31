// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftQL",
    products: [
        .library(
            name: "SwiftQL",
            targets: ["SwiftQL"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftQL",
            dependencies: []),
        .testTarget(
            name: "SwiftQLTests",
            dependencies: ["SwiftQL"]
        ),
    ]
)
