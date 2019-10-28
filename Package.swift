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
        .package(path: "../Compute"),
        .package(path: "../Concurrency"),
        .package(path: "../FoundationX"),
        .package(path: "../LinearAlgebra"),
        .package(path: "../POSIX"),
        .package(path: "../Runtime"),
        .package(path: "../Swallow")
    ],
    targets: [
        .target(name: "Data", dependencies: ["Compute", "Concurrency", "FoundationX", "LinearAlgebra", "POSIX", "Runtime", "Swallow"], path: "Sources")
    ],
    swiftLanguageVersions: [
        .version("5.1")
    ]
)
