// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let approachableConcurrency: [SwiftSetting] = [
  .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
  .enableUpcomingFeature("InferIsolatedConformances")
]

let package = Package(
  name: "NavData",
  platforms: [.macOS(.v26), .iOS(.v26), .watchOS(.v26), .tvOS(.v26), .visionOS(.v26)],
  products: [
    .library(
      name: "NavData",
      targets: ["NavData"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.4.3")
  ],
  targets: [
    .target(
      name: "NavData",
      swiftSettings: approachableConcurrency
    )
  ],
  swiftLanguageModes: [.v6]
)
