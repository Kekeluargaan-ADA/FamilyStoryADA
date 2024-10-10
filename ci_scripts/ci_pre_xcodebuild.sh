bash
#!/bin/bash
# Change to the project directory
cd ..
# Resolve Swift package dependencies
echo "Resolving Swift package dependencies..."
if [ -f "FamilyStoryADA.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved already exists."
else
    echo "Resolving packages..."
    xcodebuild -resolvePackageDependencies -project FamilyStoryADA.xcodeproj
fi