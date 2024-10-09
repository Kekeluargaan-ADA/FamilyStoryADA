#!/bin/bash
# Install XcodeGen if it's not already installed
if ! command -v xcodegen &> /dev/null; then
    echo "XcodeGen not found. Installing..."
    brew install xcodegen
fi
ls .
# Change to the project directory
cd ..
# ALL STEPS AFTER CLONE PROJECT
# Generate the Xcode project using XcodeGen
echo "Generating Xcode project..."
xcodegen
echo "Check file on .xcodeproj"
ls Chamelure.xcodeproj
echo "Check file on project.xcworkspace"
echo "Check file on xcshareddata"
ls Chamelure.xcodeproj/project.xcworkspace/xcshareddata
# BASED ON MY EXPERIENCE xcshareddata DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
mkdir -p Chamelure.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
# Create the Package.resolved file
touch Chamelure.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
echo "Creating Package.resolved..."
cat <<EOL > Chamelure.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
{
  "originHash" : "0271592b24e5dc1185a09e3f2d980d55521827815d397c9bce8e63d502a51e84",
  "pins" : [
    {
      "identity" : "tocropviewcontroller",
      "kind" : "remoteSourceControl",
      "location" : "https://github.com/TimOliver/TOCropViewController.git",
      "state" : {
        "revision" : "latest_revision_hash_here",
        "version" : "2.6.0"
      }
    }
  ],
  "version" : 3
}
EOL

# Resolve package dependencies to generate Package.resolved
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project Chamelure.xcodeproj -scheme Chamelure
# Check if Package.resolved was created
if [ -f "Chamelure.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi
