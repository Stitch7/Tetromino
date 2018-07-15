// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TetrominoScore",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.6"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc.2"),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc.4.0.1"),
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0-rc.5"),
        .package(url: "https://github.com/vapor/crypto.git", from: "3.2.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "FluentSQLite", "Authentication", "Crypto"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)



