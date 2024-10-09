bash
#!/bin/bash
# Change to the project directory
cd ..
# Check if the build succeeded
if [ $? -eq 0 ]; then
    echo "Build succeeded!"
    # You can add deployment or notification scripts here
else
    echo "Build failed!"
    exit 1
fi