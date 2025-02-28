#! /usr/bin/env python

import os
import requests
import sys
from requests.exceptions import RequestException

SPHINX_DIR = os.path.join(os.getcwd(), ".sphinx/")

GITHUB_REPO = "canonical/praecepta"
GITHUB_API_BASE = f"https://api.github.com/repos/{GITHUB_REPO}"
GITHUB_RAW_BASE = f"https://raw.githubusercontent.com/{GITHUB_REPO}"

TIMEOUT = 10  # seconds


def create_dir_if_not_exists(path):
    """Check directory of the input path, create the directory it doesn't exist"""
    dir_path = path if os.path.isdir(path) else os.path.dirname(path)
    if dir_path and not os.path.exists(dir_path):
        print(f"Creating directory: {dir_path}")
        os.makedirs(dir_path, exist_ok=True)
    else:
        print(f"Directory exists, continue with: {dir_path}")
    return dir_path

def download_file(url, output_path):
    """Download a file to the specified path"""
    try:
        print(f"  Downloading: {os.path.basename(output_path)}")
        response = requests.get(url, timeout=TIMEOUT)
        response.raise_for_status()

        create_dir_if_not_exists(output_path)
        with open(output_path, "w", encoding="utf-8") as file:
            file.write(response.text)
        return True
    except RequestException as e:
        print(f"Error downloading {url}: {e}")
        return False


def download_github_directory(url, output_dir):
    """Download all files from a GitHub directory to the specified path"""
    try:
        response = requests.get(url, timeout=TIMEOUT)
        response.raise_for_status()

        create_dir_if_not_exists(output_dir)
        items = response.json()

        # Handle GitHub API error
        if isinstance(items, dict) and 'message' in items:
            if 'rate limit' in items['message'].lower():
                print("GitHub API rate limit exceeded. Try again later.")
            print(f"GitHub API error: {items['message']}")
            return False

        total_count = len(items)
        success_count = 0
        print(f"Found {total_count} items in {url}")

        for item in items:
            if not item.get("download_url") or not item.get("name"):
                print(f"Skipping {item['name']}")
                continue
            output_file = os.path.join(output_dir, item["name"])
            if download_file(item["download_url"], output_file):
                success_count += 1
        print(f"Downloaded {success_count}/{total_count} items")
        return True
    except RequestException as e:
        print(f"Error downloading {url}: {e}")
        return False

def main():
    # Define directory paths
    rules_dir = os.path.join(SPHINX_DIR, "styles/Canonical")
    vocab_dir = os.path.join(SPHINX_DIR, "styles/config/vocabularies/Canonical")
    dict_dir = os.path.join(SPHINX_DIR, "styles/config/dictionaries")

    rules_github_url = f"{GITHUB_API_BASE}/contents/styles/Canonical"
    vocab_github_url = f"{GITHUB_API_BASE}/contents/styles/config/vocabularies/Canonical"
    dict_github_url = f"{GITHUB_API_BASE}/contents/styles/config/dictionaries"

    # Download through GitHub API
    if not download_github_directory(rules_github_url, rules_dir):
        print(f"Failed to download directory from {rules_github_url}")
        return 1
    if not download_github_directory(vocab_github_url, vocab_dir):
        print(f"Failed to download directory from {vocab_github_url}")
        return 1
    if not download_github_directory(dict_github_url, dict_dir):
        print(f"Failed to download directory from {dict_github_url}")
        return 1

    # Download vale.ini
    vale_ini_github_url = f"{GITHUB_RAW_BASE}/main/vale.ini"
    vale_ini_output = f"{SPHINX_DIR}/vale.ini"

    if not download_file(vale_ini_github_url, vale_ini_output):
        print(f"Failed to download vale.ini from {vale_ini_github_url}")
        return 1

    print("Download complete")
    return 0


if __name__ == "__main__":
    sys.exit(main())
