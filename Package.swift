// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "FoundationX",
    platforms: [.iOS(.v13),
                .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FoundationX",
            targets: ["FoundationX", "FoundationX_Objc"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "FoundationXMacro",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "FoundationX_Objc",
            dependencies: [],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath(".")],
            cxxSettings: [.headerSearchPath(".")]
        ),
        .target(
            name: "FoundationX",
            dependencies: ["FoundationX_Objc", "FoundationXMacro"],
            path: "Sources/FoundationX",
            swiftSettings: [.define("SPM_MODE")]
        ),
        .executableTarget(name: "FoundationXMacroClient", dependencies: ["FoundationX"]),
        .testTarget(
            name: "FoundationXTests",
            dependencies: ["FoundationX"]),
        .testTarget(
            name: "FoundationXObjcTests",
            dependencies: ["FoundationX"]),
    ]
)
