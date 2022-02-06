import ProjectDescription

let target = Target(
    name: "TuistAndModularArchitecture",
    platform: .iOS,
    product: .app,
    bundleId: "com.yarmolchuk.application",
    deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
    infoPlist: "TuistAndModularArchitecture/Info.plist",
    sources: ["TuistAndModularArchitecture/Application/**"],
    resources: [
        "TuistAndModularArchitecture/**/**"
    ],
    dependencies: [],
    settings: nil
)

let project = Project(
    name: "TuistAndModularArchitecture",
    targets: [target]
)
