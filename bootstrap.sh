#!/bin/bash

set +x

# Ask the user for the installation directory
read -p "Enter the installation directory (e.g., '.' or 'docs'): " install_directory

# Clone the starter pack repository
echo "Cloning the starter pack repository..."
git clone git@github.com:canonical/sphinx-docs-starter-pack temp-starter-pack
rm -rf temp-starter-pack/.git

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

# Update working-directory field in workflow files
echo "Updating working directory in workflow files..."
sed -i "s|working-directory: .*|working-directory: $install_directory|g" .github/workflows/*

# Update .readthedocs.yaml configuration
echo "Updating .readthedocs.yaml configuration..."
sed -i "s|configuration: .*|configuration: $install_directory/conf.py|g" "$install_directory/.readthedocs.yaml"
sed -i "s|requirements: .*|requirements: $install_directory/.sphinx/requirements.txt|g" "$install_directory/.readthedocs.yaml"

# Clean up
echo "Cleaning up..."
rm -rf temp-starter-pack

echo "Setup completed!"