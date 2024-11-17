// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SwiftUIExtension",
    platforms: [
        .iOS(.v15), 
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftUIExtension",
            targets: ["SwiftUIExtension"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.8")),
        .package(url: "https://github.com/siteline/swiftui-introspect", .upToNextMajor(from: "1.2.0"))
    ],
    targets: [
        .target(
            name: "SwiftUIExtension",
            dependencies: [
                .product(name: "SwiftBoost", package: "SwiftBoost"),
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
            ],
            swiftSettings: [
                .define("SWIFTUIEXTENSION_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
