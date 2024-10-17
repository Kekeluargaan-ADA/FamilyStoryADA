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
  "originHash" : "fd1d50b35c782e276a6609615f79dc050f9f1b4b7074aea1936b78dce392e805",
  "pins" : [
    {
      "identity" : "generative-ai-swift",
      "kind" : "remoteSourceControl",
      "location" : "https://github.com/google-gemini/generative-ai-swift.git",
      "state" : {
        "revision" : "44b8ce120425f9cf53ca756f3434ca2c2696f8bd",
        "version" : "0.5.6"
      }
    },
    {
      "identity" : "lottie-ios",
      "kind" : "remoteSourceControl",
      "location" : "https://github.com/airbnb/lottie-ios.git",
      "state" : {
        "revision" : "fe4c6fe3a0aa66cdeb51d549623c82ca9704b9a5",
        "version" : "4.5.0"
      }
    },
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

