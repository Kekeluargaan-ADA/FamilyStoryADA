#!/bin/bash
# Install XcodeGen if it's not already installed
if ! command -v xcodegen &> /dev/null; then
    echo "XcodeGen not found. Installing..."
    brew install xcodegen
fi
ls .
# Change to the project directory
cd ..
# Generate the Xcode project using XcodeGen
echo "Generating Xcode project..."
xcodegen
echo "Check file on .xcodeproj"
ls FamilyStoryADA.xcodeproj
echo "Check file on project.xcworkspace"
echo "Check file on xcshareddata"
ls FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata

# Ensure the xcshareddata and swiftpm directories exist
mkdir -p FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm

# Create the Package.resolved file in the correct path
echo "Creating Package.resolved..."
cat <<EOL > FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
{
  "originHash" : "13653293ccb2b03fb3a569cd04e20814001c852aa41dbb682ce436209ddd9ee2",
  "pins" : [
    {
      "identity" : "tocropviewcontroller",
      "kind" : "remoteSourceControl",
      "location" : "https://github.com/TimOliver/TOCropViewController.git",
      "state" : {
        "revision" : "a634cb7cdfd580006e79a6e74e64417fe9e9783b",
        "version" : "2.7.4"
      }
    }
  ],
  "version" : 3
}
EOL

# Resolve package dependencies
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project FamilyStoryADA.xcodeproj -scheme FamilyStoryADA

# Check if Package.resolved was created
if [ -f "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi

