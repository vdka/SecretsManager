// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "SecretsManager",
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
