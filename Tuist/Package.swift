// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "swift-dependencies": .framework,
            "Lottie": .framework,
//            "xctest-dynamic-overlay": .framework,
//            "swift-syntax": .framework,
//            "swift-concurrency-extras": .framework,
//            "swift-clocks": .framework,
//            "combine-schedulers": .framework,
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
