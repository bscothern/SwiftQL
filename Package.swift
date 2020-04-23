// swift-tools-version:5.1
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
    ]
    #endif
}

var dependencies: [Package.Dependency] {
    []
}

var targets: [Target] {
    let sharedTargets: [Target] = [
        .testTarget(
            name: "SwiftQLiteTests",
            dependencies: ["SwiftQLite"]
        ),
    ]

    #if os(Linux)
    return sharedTargets + [
        .target(
            name: "SwiftQLite",
            dependencies: [
                "SwiftQLiteLinux"
            ]
        ),
        .systemLibrary(
            name: "SwiftQLiteLinux",
            providers: [.apt(["libsqlite3-dev"])]
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
