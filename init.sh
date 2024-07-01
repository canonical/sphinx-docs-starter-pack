#!/bin/bash

# Generate a unique directory name based on timestamp
timestamp=$(date +%Y%m%d%H%M%S)
temp_directory="temp-starter-pack-$timestamp"

# Ask the user for the installation directory
read -p "Enter the installation directory (e.g., '.' or 'docs'): " install_directory

# Clone the starter pack repository to the temporary directory
echo "Cloning the starter pack repository..."
git clone --depth 1 -b use-canonical-sphinx-extension --single-branch https://github.com/canonical/starter-pack "$temp_directory"
#git clone --depth 1 https://github.com/canonical/sphinx-docs-starter-pack "$temp_directory"
rm -rf "$temp_directory/.git"

# Update file contents for the install directory
echo "Updating working directory in workflow files..."
sed -i "s|working-directory:\s*'\.'|working-directory: '$install_directory'|g" "$temp_directory/sp-files/.github/workflows"/*
echo "Updating .readthedocs.yaml configuration..."
sed -i "s|configuration:\s*sp-docs/conf\.py|configuration: $install_directory/conf.py|g" "$temp_directory/sp-files/.readthedocs.yaml"
sed -i "s|requirements:\s*sp-docs/\.sphinx/requirements\.txt|requirements: $install_directory/.sphinx/requirements.txt|g" "$temp_directory/.readthedocs.yaml"
echo "Updating conf.py configuration..."
if [ "$install_directory" == "." ]; then
    sed -i "s|'github_folder':\s*'/sp-docs/'|'github_folder': '/'|g" "$temp_directory/sp-files/conf.py"
else
    sed -i "s|'github_folder':\s*'/sp-docs/'|'github_folder': '/$install_directory/'|g" "$temp_directory/sp-files/conf.py"
fi

# Create the specified installation directory if it doesn't exist
if [ ! -d "$install_directory" ]; then
    echo "Creating the installation directory: $install_directory"
    mkdir -p "$install_directory"
fi

# Copy the contents of the starter pack repository to the installation directory
echo "Copying contents to the installation directory..."
cp -R "$temp_directory"/sp-files/* "$temp_directory"/sp-files/.??* "$install_directory"

# Move workflow files and configuration
if [ "$install_directory" != "." ]; then
    echo "Moving workflow files and configuration..."
    if [ ! -d .github/workflows ]; then
        mkdir -p .github/workflows
    fi
    mv "$install_directory/.github/workflows"/* .github/workflows
    rmdir -p --ignore-fail-on-non-empty "$install_directory/.github/workflows"
    if [ ! -f .wokeignore ]; then
        ln -s "$install_directory/.wokeignore"
    else
        echo "ACTION REQUIRED: Found a .wokeignore file in the root directory. Include the contents from $install_directory/.wokeignore in this file!"
    fi
fi

# Clean up
echo "Cleaning up..."
rm -rf "$temp_directory"

echo "Setup completed!"
