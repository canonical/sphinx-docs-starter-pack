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
sed -i "s|requirements:\s*sp-docs/\.sphinx/requirements\.txt|requirements: $install_directory/.sphinx/requirements.txt|g" "$temp_directory/sp-files/.readthedocs.yaml"
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

# Check if .gitignore exists in the destination directory
# If exists, append the contents of the source .gitignore to the destination .gitignore
if [ -f "$install_directory/.gitignore" ]; then
    echo "ACTION REQUIRED: .gitignore already exists in the destination directory. Check the contents before saving the file!"
    read -p "Do you want to append the list of ignored files for Sphinx docs to the existing .gitginore? Enter 'n' to skip. (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        echo "Appending contents to the existing .gitignore..."
        cat "$temp_directory/sp-files/.gitignore" >> "$install_directory/.gitignore"
    else
        echo "Operation skipped by the user. Add the .gitignore rules for the Sphinx docs to your .gitignore file manually."
    rm "$temp_directory/sp-files/.gitignore"
fi

# Check if Makefile exists in the destination directory
if [ -f "$install_directory/Makefile" ]; then
    echo "ACTION REQUIRED: Makefile already exists in the destination directory. Check the contents before running the targets!"
    read -p "Do you want to add the Sphinx docs targets into the Makefile? The existing file will be saved a backup file. Enter 'n' to skip. (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        # Create a copy of the existing Makefile as backup
        existing_makefile="$install_directory/Makefile"
        backup_makefile="$install_directory/Makefile.backup.$(date +%Y%m%d%H%M%S)"
        echo "Creating a backup: $backup_makefile"
        cp "$existing_makefile" "$backup_makefile"

        echo "Appending Sphinx docs targets to the existing Makefile..." 
        echo "" >> "$existing_makefile"    # Add a new line before appending the contents
        cat "$temp_directory/sp-files/Makefile" >> "$existing_makefile"
    else
        echo "Operation skipped by the user. Add the Makefile targets for Sphinx docs manually."
    rm "$temp_directory/sp-files/Makefile"
fi

# Copy the rest of the starter pack repository to the installation directory
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
