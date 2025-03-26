#! /usr/bin/env python

import os
import shutil
import subprocess
import tempfile
import requests
import sys
import logging
from requests.exceptions import RequestException

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

SPHINX_DIR = os.path.join(os.getcwd(), ".sphinx")

GITHUB_REPO = "canonical/praecepta"
GITHUB_API_BASE = f"https://api.github.com/repos/{GITHUB_REPO}"
GITHUB_RAW_BASE = f"https://raw.githubusercontent.com/{GITHUB_REPO}"
GITHUB_CLONE_URL = f"https://github.com/{GITHUB_REPO}.git"

TIMEOUT = 10  # seconds

# Source paths in repo and their destinations in .sphinx
VALE_FILE_LIST = [
    "styles/Canonical",
    "styles/config/vocabularies/Canonical",
    "styles/config/dictionaries",
    "vale.ini"
]


def create_dir_if_not_exists(dir_path):
    """Check directory of the input path, create the directory it doesn't exist"""
    if dir_path and not os.path.exists(dir_path):
        logging.info("Creating directory: %s", dir_path)
        os.makedirs(dir_path, exist_ok=True)
    else:
        logging.info("Directory exists, continue with: %s", dir_path)
    return dir_path


def download_file(url, output_path):
    """Download a file to the specified path"""
    try:
        logging.info("  Downloading: %s", os.path.basename(output_path))
        response = requests.get(url, timeout=TIMEOUT)
        response.raise_for_status()

        with open(output_path, "wb") as file:
            file.write(response.content)  # binary or text data
        return True
    except RequestException as e:
        logging.error("Error downloading %s: %s", url, e)
        return False


def clone_repo_and_copy_paths(file_source_dest, overwrite=False):
    """
    Clone the repository to a temporary directory and copy required files
    
    file_source_dest: dictionary of file paths to copy from the repository, and their destination paths
    overwrite: boolean flag to overwrite existing files in the destination
    """

    if not file_source_dest:
        logging.error("No files to copy")
        return False

    # Create temporary directory on disk for cloning
    temp_dir = tempfile.mkdtemp()
    logging.info("Cloning repository <%s> to temporary directory: %s", GITHUB_REPO, temp_dir)
    clone_cmd = ["git", "clone", "--depth", "1", GITHUB_CLONE_URL, temp_dir]

    try:
        result = subprocess.run(
            clone_cmd, 
            capture_output=True, 
            text=True,
            check=True
        )
        logging.debug("Git clone output: %s", result.stdout)
    except subprocess.CalledProcessError as e:
        logging.error("Git clone failed: %s", e.stderr)
        return False

    # Copy files from the cloned repository to the destination paths
    is_copy_success = True
    for source, dest in file_source_dest.items():
        source_path = os.path.join(temp_dir, source)

        if not os.path.exists(source_path):
            is_copy_success = False
            logging.error("Source path not found: %s", source_path)
            continue

        if not copy_files_to_path(source_path, dest, overwrite):
            is_copy_success = False            
            logging.error("Failed to copy %s to %s", source_path, dest)

    # Clean up temporary directory
    logging.info("Cleaning up temporary directory: %s", temp_dir)
    shutil.rmtree(temp_dir)

    return is_copy_success

def copy_files_to_path(source_path, dest_path, overwrite=False):
    """
    Copy a file or directory from source to destination
    
    Args:
        source_path: Path to the source file or directory
        dest_path: Path to the destination
        
    Returns:
        bool: True if copy was successful, False otherwise
    """
    # Skip if source file doesn't exist
    if not os.path.exists(source_path):
        logging.warning("Source path not found: %s", source_path)
        return False

    logging.info("Copying %s to %s", source_path, dest_path)
    # Handle existing files
    if os.path.exists(dest_path):
        if overwrite:
            logging.info("  Destination exists, overwriting: %s", dest_path)
            if os.path.isdir(dest_path):
                shutil.rmtree(dest_path)
            else:
                os.remove(dest_path)
        else:
            logging.info("  Destination exists, skip copying (use overwrite=True to replace): %s", dest_path)
            return True     # Skip copying

    # Copy the source to destination
    try:
        if os.path.isdir(source_path):
            # entire directory
            shutil.copytree(source_path, dest_path)
        else:
            # individual files
            shutil.copy2(source_path, dest_path)
        return True
    except (shutil.Error, OSError) as e:
        logging.error("Copy failed: %s", e)
        return False

def download_github_directory(url, output_dir):
    """Download all files from a GitHub directory to the specified path"""
    try:
        response = requests.get(url, timeout=TIMEOUT)
        response.raise_for_status()

        create_dir_if_not_exists(output_dir)
        items = response.json()

        # Handle GitHub API error
        if isinstance(items, dict) and "message" in items:
            if "rate limit" in items["message"].lower():
                logging.error("GitHub API rate limit exceeded. Try again later.")
            logging.error("GitHub API error: %s", items['message'])
            return False

        success_count = 0
        for item in items:
            # Handle subdirectories recursively
            if item.get("type") == "dir":
                dir_name = item.get("name", "")
                sub_output_dir = os.path.join(output_dir, dir_name)
                sub_url = item.get("url", "")
                if sub_url and download_github_directory(
                    sub_url, sub_output_dir
                ):
                    success_count += 1
                continue

            # Skip files without download URL or name
            if not item.get("download_url") or not item.get("name"):
                logging.warning("Skipping %s", item['name'])
                continue

            # Download leaf files
            output_file = os.path.join(output_dir, item["name"])
            if download_file(item["download_url"], output_file):
                success_count += 1

        logging.info("Downloaded %d items", success_count)
        return True
    except RequestException as e:
        logging.error("Error downloading %s: %s", url, e)
        return False

def main():
    # Define local directory paths
    vale_files_dict = {file: os.path.join(SPHINX_DIR, file) for file in VALE_FILE_LIST}

    # Download into /tmp through git clone 
    if not clone_repo_and_copy_paths(vale_files_dict, overwrite=True):
        logging.error("Failed to download files from repository")
        return 1

    logging.info("Download complete")
    return 0


if __name__ == "__main__":
    sys.exit(main())  # Keep return code
