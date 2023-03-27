// swift-tools-version:5.5
import PackageDescription

// Workaround for Xcode 13.2(.1) with Swift 5.5.2, but SwiftPM 5.5.0
#if swift(>=5.5.2)
let platforms: [SupportedPlatform] = [
    .macOS(.v10_15),
    .iOS(.v13),
    .watchOS(.v6)
]
#else
let platforms: [SupportedPlatform] = [
    .macOS(.v12),
    .iOS(.v15),
    .watchOS(.v8)
]
#endif

let package = Package(
    name: "fluent",
    platforms: platforms,
    products: [
        .library(name: "Fluent", targets: ["Fluent"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/fluent-kit.git", from: "1.38.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.50.0"),
    ],
    targets: [
        .target(name: "Fluent", dependencies: [
            .product(name: "FluentKit", package: "fluent-kit"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "FluentTests", dependencies: [
            .target(name: "Fluent"),
            .product(name: "XCTFluent", package: "fluent-kit"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
    ]
)
