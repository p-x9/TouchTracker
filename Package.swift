// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TouchTracker",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TouchTracker",
            targets: ["TouchTracker"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TouchTracker",
            dependencies: []
        ),
        .testTarget(
            name: "TouchTrackerTests",
            dependencies: ["TouchTracker"]
        )
    ]
)
