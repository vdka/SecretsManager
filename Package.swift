// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SecretsManager",
    platforms: [.iOS(.v14), .macOS(.v13)],
    products: [
        .executable(name: "SecretsManager", targets: ["SecretsManager"]),
        .plugin(name: "SecretsManagerPlugin", targets: ["SecretsManagerPlugin"]),
    ],
    targets: [
        .executableTarget(
            name: "SecretsManager",
            dependencies: []
        ),
        .plugin(name: "SecretsManagerPlugin", capability: .buildTool(), dependencies: ["SecretsManager"]),
    ]
)
