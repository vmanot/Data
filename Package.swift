// swift-tools-version:5.1

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
        .package(url: "git@github.com:vmanot/Compute", .branch("master")),
        .package(url: "git@github.com:vmanot/Concurrency", .branch("master")),
        .package(url: "git@github.com:vmanot/FoundationX", .branch("master")),
        .package(url: "git@github.com:vmanot/Merge", .branch("master")),
        .package(url: "git@github.com:vmanot/Runtime", .branch("master")),
        .package(url: "git@github.com:vmanot/Swallow", .branch("master"))
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
    ],
    swiftLanguageVersions: [
        .version("5.1")
    ]
)
