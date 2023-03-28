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
        .package(url: "https://github.com/mteep/fluent-kit.git", branch: "xcode-on-big-sur"),
        .package(url: "https://github.com/mteep/vapor.git", branch: "xcode-on-big-sur"),
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
