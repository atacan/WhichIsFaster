// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhichOneIsFaster",
    platforms: [.macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "WhichOneIsFaster", targets: ["WhichOneIsFaster"]),
    ],
    dependencies: [
        // Codability
        .package(url: "https://github.com/google/swift-benchmark", branch: "main"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/orlandos-nl/IkigaJSON.git", from: "2.0.0"),
        .package(url: "https://github.com/CoreOffice/XMLCoder.git", from: "0.15.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.5"),
        .package(url: "https://github.com/mongodb/mongo-swift-driver", .upToNextMajor(from: "1.3.1")),
        .package(url: "https://github.com/lynixliu/SwiftAvroCore", from: "0.3.0"),
        .package(url: "https://github.com/valpackett/SwiftCBOR", branch: "master"),

        // Markdown
        .package(url: "https://github.com/loopwerk/Parsley", from: "0.5.0"),
        // .package(url: "https://github.com/brokenhandsio/cmark-gfm.git", from: "2.0.0"),
        .package(url: "https://github.com/johnxnguyen/Down", from: "0.9.0"),
        .package(url: "https://github.com/johnsundell/ink.git", from: "0.1.0"),
        .package(url: "https://github.com/objecthub/swift-markdownkit", branch: "master"),
        // .package(url: "https://github.com/KristopherGBaker/Maaku.git", from: "0.6.0"),
        // .package(url: "https://github.com/apple/swift-cmark", branch: "gfm"),

        .package(url: "https://github.com/pointfreeco/swift-prelude.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WhichOneIsFaster",
            dependencies: []
        ),
        .executableTarget(
            name: "SwitchVsDictionary",
            dependencies: [.product(name: "Benchmark", package: "swift-benchmark")]
        ),
        .executableTarget(
            name: "EnumVsOptionSet",
            dependencies: [.product(name: "Benchmark", package: "swift-benchmark")]
        ),
        .executableTarget(
            name: "JsonVsProtobuf",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "Benchmark", package: "swift-benchmark"),
                .product(name: "IkigaJSON", package: "IkigaJSON"),
                .product(name: "XMLCoder", package: "XMLCoder"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "MongoSwift", package: "mongo-swift-driver"),
                .product(name: "SwiftAvroCore", package: "SwiftAvroCore"),
                .product(name: "SwiftCBOR", package: "SwiftCBOR"),
            ],
            resources: [.copy("Resources")]
        ),
        .executableTarget(
            name: "MarkdownParsers",
            dependencies: [
                .product(name: "Benchmark", package: "swift-benchmark"),
                .product(name: "Parsley", package: "Parsley"),
                //                .product(name: "Down", package: "Down"),
                //                .product(name: "cmark", package: "cmark-gfm"),
                .product(name: "Ink", package: "ink"),
                .product(name: "MarkdownKit", package: "swift-markdownkit"),
//                .product(name: "Maaku", package: "Maaku"),
//                .product(name: "cmark-gfm", package: "swift-cmark"),
            ]
        ),
        .executableTarget(
            name: "DownAlone",
            dependencies: [
                .product(name: "Benchmark", package: "swift-benchmark"),
                .product(name: "Down", package: "Down"),
                .product(name: "Ink", package: "ink"),
            ]
        ),
        .executableTarget(
            name: "SwitchVsContains",
            dependencies: [
                .product(name: "Benchmark", package: "swift-benchmark"),
                .product(name: "Prelude", package: "swift-prelude"),
            ]
        ),
        .executableTarget(
            name: "StringConcatenation",
            dependencies: [
                .product(name: "Benchmark", package: "swift-benchmark"),
            ]
        ),

        .systemLibrary(
            name: "Ccmark",
            pkgConfig: "cmark-gfm",
            providers: [
                .brew(["cmark-gfm"]),
            ]
        ),

        .executableTarget(name: "TryCMark", dependencies: ["Ccmark",
                                                           .product(name: "Benchmark", package: "swift-benchmark")]),

        .testTarget(
            name: "WhichOneIsFasterTests",
            dependencies: ["WhichOneIsFaster"]
        ),
    ]
)
