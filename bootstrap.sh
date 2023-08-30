#!/bin/bash

set +x

# Ask the user for the installation directory
read -p "Enter the installation directory (e.g., '.' or 'docs'): " install_directory

# Clone the starter pack repository to a temporary directory
echo "Cloning the starter pack repository..."
git clone --depth 1 git@github.com:canonical/sphinx-docs-starter-pack temp-starter-pack
rm -rf temp-starter-pack/.git

# Update file contents for install directory
echo "Updating working directory in workflow files..."
sed -i "s|working-directory: .*|working-directory: $install_directory|g" "temp-starter-pack/.github/workflows"/*
echo "Updating .readthedocs.yaml configuration..."
sed -i "s|configuration:\s*conf\.py|configuration: $install_directory/conf.py|g" "temp-starter-pack/.readthedocs.yaml"
sed -i "s|requirements:\s*\.sphinx/requirements\.txt|requirements: $install_directory/.sphinx/requirements.txt|g" "temp-starter-pack/.readthedocs.yaml"

# Create the specified installation directory
echo "Creating the installation directory: $install_directory"
mkdir -p "$install_directory"

# Copy the contents of the starter pack repository to the installation directory
echo "Copying contents to the installation directory..."
cp -R temp-starter-pack/* temp-starter-pack/.??* "$install_directory"

# Copy workflow files
echo "Copying workflow files..."
mkdir -p .github/workflows
cp -R "$install_directory/.github/workflows"/* .github/workflows

# Clean up
echo "Cleaning up..."
rm -rf temp-starter-pack

echo "Setup completed!"