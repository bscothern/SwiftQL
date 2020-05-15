// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var products: [Product] {
    #if os(Linux)
    return []
    #else
    return [
        .library(
            name: "SwiftQLite",
            targets: ["SwiftQLite"]
        ),
        .library(
            name: "SwiftQLiteQuery",
            targets: ["SwiftQLiteQuery"]
        ),
    ]
    #endif
}

var dependencies: [Package.Dependency] {
    []
}

var targets: [Target] {
    let sharedTargets: [Target] = [
        .target(
            name: "SwiftQLiteQuery"
        ),
        .testTarget(
            name: "SwiftQLiteQueryTests",
            dependencies: [
                .target(name: "SwiftQLiteQuery")
            ]
        ),
    ]

    #if os(Linux)
    return sharedTargets + [
        .target(
            name: "SwiftQLite",
            dependencies: [
                .target(name: "SwiftQLiteLinux")
            ]
        ),
        .systemLibrary(
            name: "SwiftQLiteLinux",
            providers: [
                .apt(["libsqlite3-dev"])
            ]
        )
    ]
    #else
    return sharedTargets + [
        .target(
            name: "SwiftQLite",
            dependencies: []
        ),
    ]
    #endif
}

let package = Package(
    name: "SwiftQLite",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: products,
    dependencies:dependencies,
    targets: targets
)
