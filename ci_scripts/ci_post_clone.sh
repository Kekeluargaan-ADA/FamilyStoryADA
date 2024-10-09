bash
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
ls FamilyStoryADA.xcodeproj
echo "Check file on project.xcworkspace"
echo "Check file on xcshareddata"
ls FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata
# BASED ON MY EXPERIENCE xcshareddata DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
mkdir FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata
# BASED ON MY EXPERIENCE swiftpm DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
mkdir FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
# BASED ON MY EXPERIENCE Package.resolved DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
touch FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
echo "Creating Package.resolved..."
cat <<EOL > FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
# CREATE YOUR EXAMPLE DEPENDENCY HERE, ONLY FOR CREATING Package.resolved
{
  "originHash" : "",
  "pins" : [
    {
      "identity" : "",
      "kind" : "",
      "location" : "",
      "state" : {
        "revision" : "",
        "version" : ""
      }
    }
  ],
  "version" : 3
}
EOL
# Resolve package dependencies to generate Package.resolved
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project FamilyStoryADA.xcodeproj -scheme FamilyStoryADA
# Check if Package.resolved was created
if [ -f "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi
