#!/bin/bash

set -euo pipefail

# Check if the script is running in the expected root directory
if [ ! -e ".git" ]; then
    echo "ERROR: This script must be run from the root directory of the repository."
    exit 1
fi

# Check if an installation directory argument is supplied; if not, prompt for it
install_directory="${1:-}"
if [ -z "$install_directory" ]; then

    read -rp "Enter the installation directory (e.g., '.' or 'docs'): " install_directory
fi

# Check if md or rst is preferred for the documentation being built
promptForFileChoice()
{
while true; do
    read -p "Will you be using the 'rst' or 'md' file format for the documentation (default: 'rst'): " filetype_choice

    filetype_choice=${filetype_choice:-rst}

    if [ "$filetype_choice" = "md" ] || [ "$filetype_choice" = "rst" ]; then
        file_type="$filetype_choice"
        echo "Setting filetype to: $file_type"
        break
    else
        echo "Invalid input. Please enter either 'md' or 'rst':"
    fi
done
}

# If default variable for filetype choice is defined in CI then don't prompt user for choice
if [ -z "${default_filetype_choice:-}" ]; then
    promptForFileChoice
else
    file_type="$default_filetype_choice"
    echo "Using predefined filetype choice: $file_type"
fi

# Normalise the install_directory path
install_directory=$(realpath -m --relative-to="$(pwd)" "$install_directory")
echo "Installing at $install_directory..."

# Come up with a unique temporary directory name based on the current timestamp
temp_directory="temp-starter-pack-$(date +%Y%m%d%H%M%S)"

# Clone the starter pack repository into the temporary directory and de-git it
echo "Cloning the starter pack repository..."
git clone --depth 1 -b use-canonical-sphinx-extension --single-branch https://github.com/canonical/starter-pack "$temp_directory"
rm -rf "$temp_directory/.git"

# Update workflow and documentation files based on the installation directory
echo "Updating working directory in workflow files..."
sed -i "s|working-directory:\s*'\.'|working-directory: '$install_directory'|g" "$temp_directory/sp-files/.github/workflows"/*
echo "Updating .readthedocs.yaml configuration..."
sed -i "s|configuration:\s*sp-docs/conf\.py|configuration: $install_directory/conf.py|g" "$temp_directory/sp-files/.readthedocs.yaml"
sed -i "s|requirements:\s*sp-docs/\.sphinx/requirements\.txt|requirements: $install_directory/.sphinx/requirements.txt|g" "$temp_directory/sp-files/.readthedocs.yaml"
echo "Updating contribution guide..."
sed -i "s|DOCDIR|$install_directory|g" "$temp_directory/sp-files/contributing.rst"

# Update the GitHub folder path in the configuration file
echo "Updating conf.py configuration..."
github_folder="/$install_directory/"
[ "$install_directory" == "." ] && github_folder="/"
sed -i "s|'github_folder':\s*'/sp-docs/'|'github_folder': '$github_folder'|g" "$temp_directory/sp-files/conf.py"

# Tell that the directory's about to be created if it doesn't exist
if [ ! -d "$install_directory" ]; then
    echo "Creating the installation directory: $install_directory"
    mkdir -p "$install_directory"
fi

# Check if .gitignore exists in the destination directory
# If it does, append the contents of the source .gitignore to the destination
if [ -f "$install_directory/.gitignore" ]; then
    echo "ACTION REQUIRED: .gitignore already exists in the destination directory."
    read -p "Do you want to append the list of ignored files for Sphinx docs to the existing .gitignore? Enter 'n' to skip. (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        echo "Appending contents to the existing .gitignore..."
        cat "$temp_directory/sp-files/.gitignore" >> "$install_directory/.gitignore"
    else
        echo "Operation skipped by the user. Add the .gitignore rules for the Sphinx docs to your .gitignore file manually."
    fi
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
    fi
    rm "$temp_directory/sp-files/Makefile"
fi

# Copy the rest of the starter pack repository to the installation directory
echo "Copying contents to the installation directory..."
cp -R "$temp_directory"/sp-files/* "$temp_directory"/sp-files/.??* "$install_directory"

# Delete files with unpreferred filetype in the installation directory
# No wildcard delete to avoid data loss if user Git-inits in dir with pre-existing files
if [ -z "${default_filetype_choice:-}" ]; then
    echo "Default filetype not defined, so proceed with deleting unpreferred filetype."
    if [ "$file_type" = 'md' ]; then
        echo "Deleting .rst files..."
        rm "$install_directory"/doc-cheat-sheet.rst
        rm "$install_directory"/index.rst
    else
        echo "Deleting .md files..."
        rm "$install_directory"/doc-cheat-sheet-myst.md
        rm "$install_directory"/index.md
    fi
else
    echo "Default filetype is defined, so skip filetype deletion."
fi

# Ensure GitHub workflows and woke config are placed in the repo root
# if installing in a non-root directory
if [ "$install_directory" != "." ]; then
    echo "Handling GitHub workflow files and .wokeignore configuration..."
    mkdir -p .github/workflows
    for file in "$install_directory/.github/workflows/"*; do
        [ -f "$file" ] || continue
        basefile=$(basename "$file")
        if [ ! -f .github/workflows/"$basefile" ]; then
            mv "$file" .github/workflows/
        else
            echo "ACTION REQUIRED: GitHub workflow '$basefile' already exists and was not overwritten."
        fi
    done
    rmdir -p --ignore-fail-on-non-empty "$install_directory/.github/workflows"

    if [ -f "$install_directory/.wokeignore" ]; then
        if [ -f .wokeignore ]; then
            echo "ACTION REQUIRED: A .wokeignore file already exists in the root directory."
            read -p "Do you want to append the contents of $install_directory/.wokeignore to the existing .wokeignore? Enter 'n' to skip. (y/n): " confirm
            if [ "$confirm" = "y" ]; then
                echo "Appending contents to the existing .wokeignore..."
                cat "$install_directory/.wokeignore" >> .wokeignore
                rm "$install_directory/.wokeignore"
            else
                echo "Operation skipped by the user. Add the rules from $install_directory/.wokeignore to your .wokeignore file manually."
            fi
        else
            ln -s "$install_directory/.wokeignore" .wokeignore
        fi
    fi
fi

# Clean up the temporary directory
echo "Cleaning up temporary files..."
rm -rf "$temp_directory"

echo "Setup successfully completed!"
