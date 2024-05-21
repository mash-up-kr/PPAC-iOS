// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "Dependencies": .framework,
            "Lottie": .framework
        ]
    )
#endif

let package = Package(
    name: "PPAC-IOS",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.3"),
    ]
)
