// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppointletSwiftSDK",
    platforms: [
        .iOS(.v10), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "AppointletSwiftSDK",
            targets: ["AppointletSwiftSDK"]),
    ],
    dependencies: [
        // List any dependencies here, if any.
    ],
    targets: [
        .target(
            name: "AppointletSwiftSDK",
            dependencies: []),
        .testTarget(
            name: "AppointletSwiftSDKTests",
            dependencies: ["AppointletSwiftSDK"]),
    ]
)
