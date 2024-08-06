// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "swift-dependencies": .framework,
            "Lottie": .framework,
            "Kingfisher": .framework,
            "PopupView": .framework,
            "SkeletonUI": .framework,
        ]
    )
#endif

let package = Package(
    name: "PPAC-IOS",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.3"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/exyte/PopupView.git", from: "3.0.4"),
        .package(url: "https://github.com/CSolanaM/SkeletonUI.git", from: "2.0.2")
    ]
)
