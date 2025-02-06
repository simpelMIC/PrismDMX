// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let package = Package(
    name: "PrismDMX",
    platforms: [
        .macOS(.v12) // SwiftCrossUI requires macOS 12+
    ],
    dependencies: [
        .package(url: "https://github.com/stackotter/swift-cross-ui", branch: "main"),
        .package(
            url: "https://github.com/stackotter/swift-bundler",
            revision: "412e8a3838456654138ac807406aba27599762f1"
        )
    ],
    targets: [
        .executableTarget(
            name: "PrismDMX",
            dependencies: [
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "DefaultBackend", package: "swift-cross-ui"),
                .product(name: "SwiftBundlerRuntime", package: "swift-bundler", condition: .when(platforms: [.macOS, .linux]))
            ]
        )
    ]
)
