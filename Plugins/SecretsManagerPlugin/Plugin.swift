
import PackagePlugin
import class Foundation.FileManager

@main
struct SecretsManagerPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let envPath = context.package.directory.appending(subpath: ".env")
        let outPath = context.pluginWorkDirectory.appending(subpath: "GeneratedSecrets.swift")
        guard FileManager.default.fileExists(atPath: envPath.string) else {
            Diagnostics.error("❗️ No .env file at path '\(envPath)'")
            return []
        }
        return [command("SecretsManager", executable: try context.tool(named: "SecretsManager").path, envPath: envPath, outPath: outPath)]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SecretsManagerPlugin: XcodeBuildToolPlugin {

    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        let envPath = context.xcodeProject.directory.appending(subpath: ".env")
        let outPath = context.pluginWorkDirectory.appending(subpath: "GeneratedSecrets.swift")
        guard FileManager.default.fileExists(atPath: envPath.string) else {
            Diagnostics.error("❗️ No .env file at path '\(envPath)'")
            return []
        }
        return [command("SecretsManager", executable: try context.tool(named: "SecretsManager").path, envPath: envPath, outPath: outPath)]
    }
}
#endif

func command(_ name: String, executable: Path, envPath: Path, outPath: Path) -> Command {
    .buildCommand(
        displayName: name,
        executable: executable,
        arguments: [envPath.string, outPath.string],
        inputFiles: [envPath],
        outputFiles: [outPath]
    )
}
