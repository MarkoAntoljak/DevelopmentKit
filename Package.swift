// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "DevelopmentKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "DevelopmentKit", targets: ["DevelopmentKit"])
    ],
    targets: [
        .target(
            name: "DevelopmentKit",
            path: "Source"
        )
    ],
    swiftLanguageVersions: [.v5]
)
