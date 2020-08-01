// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "Data", targets: ["Data"])
    ],
    dependencies: [
        .package(url: "git@github.com:vmanot/Compute.git", .branch("master")),
        .package(url: "git@github.com:vmanot/Concurrency.git", .branch("master")),
        .package(url: "git@github.com:vmanot/FoundationX.git", .branch("master")),
        .package(url: "git@github.com:vmanot/Merge.git", .branch("master")),
        .package(url: "git@github.com:vmanot/Runtime.git", .branch("master")),
        .package(url: "git@github.com:vmanot/Swallow.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "Compute",
                "Concurrency",
                "FoundationX",
                "Merge",
                "Runtime",
                "Swallow"
            ],
            path: "Sources"
        )
    ]
)
