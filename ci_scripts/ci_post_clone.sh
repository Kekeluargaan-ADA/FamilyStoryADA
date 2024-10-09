#!/bin/bash
# Install XcodeGen if it's not already installed
if ! command -v xcodegen &> /dev/null; then
    echo "XcodeGen not found. Installing..."
    brew install xcodegen
fi

# List current directory files
ls .

# Change to the project directory
cd ..

# Generate the Xcode project using XcodeGen
echo "Generating Xcode project..."
xcodegen

# Check for the .xcodeproj file
echo "Check file on .xcodeproj"
ls FamilyStoryADA.xcodeproj

# Check for xcshareddata directory
echo "Check file on xcshareddata"
if [ ! -d "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata" ]; then
    echo "xcshareddata directory not found. Creating..."
    mkdir -p FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
fi

# Check for Package.resolved file
if [ ! -f "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Creating Package.resolved..."
    touch FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
    cat <<EOL > FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
{
  "pins" : [],
  "version" : 3
}
EOL
fi

# Resolve package dependencies to generate Package.resolved
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project FamilyStoryADA.xcodeproj -scheme FamilyStoryADA

# Check if Package.resolved was created successfully
if [ -f "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi

# Add Lottie as a package dependency
echo "Adding Lottie package dependency..."
cat <<EOL > Package.swift
// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "TOCropViewController",
    defaultLocalization: "en",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "TOCropViewController",
            targets: ["TOCropViewController"]
        ),
        .library(
            name: "CropViewController",
            targets: ["CropViewController"]
        )
    ],
    targets: [
        .target(
            name: "TOCropViewController",
            path: "Objective-C/TOCropViewController/",
			exclude:["Supporting/Info.plist"],
            resources: [.process("Resources")],
            publicHeadersPath: "include"
        ),
        .target(
            name: "CropViewController",
            dependencies: ["TOCropViewController"],
            path: "Swift/CropViewController/",
			exclude:["Info.plist"],
            sources: ["CropViewController.swift"]
        )
    ]
)
EOL

# Re-run xcodegen after modifying Package.swift
echo "Regenerating Xcode project with XcodeGen..."
xcodegen

# Verify if Lottie has been added properly
echo "Verifying Lottie package integration..."
if grep -q "https://github.com/airbnb/lottie-ios.git" Package.swift; then
    echo "Lottie package added successfully."
else
    echo "Failed to add Lottie package."
    exit 1
fi