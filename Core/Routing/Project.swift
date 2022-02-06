import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
    name: "Routing",
    packages: [],
    dependencies: []
)

extension Project {
    public static func feature(
        name: String,
        packages: [Package],
        dependencies: [TargetDependency]
    ) -> Self {
        Self(
            name: name,
            packages: packages,
            targets: [
                Target(
                    name: name,
                    platform: .iOS,
                    product: .staticFramework,
                    bundleId: "com.yarmolchuk.application.\(name)",
                    deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
