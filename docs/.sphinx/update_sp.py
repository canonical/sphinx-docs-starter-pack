#! /usr/bin/env python

# Initial update script for the starter pack.
#
# Requires some manual intervention, but makes identifying updates and differences easier.
#
# For debugging, please run this script with DEBUGGING=1
# e.g. user@device:~/git/Canonical/sphinx-docs-starter-pack/docs$ DEBUGGING=1 python .sphinx/update_sp.py


import glob
import logging
import os
import requests
import subprocess
import sys
from requests.exceptions import RequestException

SPHINX_DIR = os.path.join(os.getcwd(), ".sphinx")
SPHINX_UPDATE_DIR = os.path.join(SPHINX_DIR, "update")
GITHUB_REPO = "secondskoll/sphinx-docs-starter-pack"
GITHUB_API_BASE = f"https://api.github.com/repos/{GITHUB_REPO}"
GITHUB_RAW_BASE = f"https://raw.githubusercontent.com/{GITHUB_REPO}/main"

TIMEOUT = 10  # seconds

# Check if debugging
if os.getenv("DEBUGGING"):
    logging.basicConfig(level=logging.DEBUG)


def main():
    # Check local version
    logging.debug("Checking local version")
    try:
        with open(SPHINX_DIR.join("version")) as f:
            current_version = f.read()
    except FileNotFoundError:
        print("WARNING\nWARNING\nWARNING")
        print(
            "You need to update to at least version 1.0.0 of the starter pack to start using the update function."
        )
        print("You may experience issues using this functionality.")
        logging.debug("No local version found. Setting version to None")
        current_version = "None"
    except Exception as e:
        raise Exception("ERROR executing check local version: " + e)
    logging.debug("Local version = " + current_version)

    # Check release version
    current_release = query_api(GITHUB_API_BASE + "/releases/latest").json()["tag_name"]
    logging.debug("current release = " + current_release)

    # Perform actions only if versions are different
    logging.debug("Comparing versions")
    if current_version != current_release:
        logging.debug("Difference identified in current version and release version.")
        print("Starter pack is out of date.\n")

        # Identify and download '.sphinx' dir files to '.sphinx/update'
        files_updated, new_files = update_static_files()

        # Write new version to file to '.sphinx/update'

        download_file(
            GITHUB_RAW_BASE + "/docs/.sphinx/version",
            os.path.join(SPHINX_UPDATE_DIR, "version"),
        )

        # Provide changelog to identify other significant changes
        changelog = query_api(GITHUB_RAW_BASE + "/CHANGELOG.md")
        logging.debug("Changelog obtained")
        try:
            new, old = changelog.text.split("## " + current_version)
            print(new)
        except ValueError:
            print("WARNING\nWARNING\nWARNING")
            print(
                "Current version not identified. It is recommended to examine the CHANGELOG and update manually."
            )

        # Provide information on any files identified for updates
        if files_updated:
            logging.debug("Updated files found and downloaded")
            print("Differences have been identified in static files.")
            print("Updated files have been downloaded to '.sphinx/update'.")
            print("Move these files into your '.sphinx/' directory.")
        else:
            logging.debug("No files found to update")
        # Provide information on NEW files
        if new_files:
            logging.debug("New files found and downloaded")
            print(
                "\nNOTE: New files have been downloaded: See 'NEWFILES.txt' for details."
            )
        else:
            logging.debug("No new files found to download")
    else:
        logging.debug("Local version and release version are the same")
        print("This version is up to date.")

    # Check requirements are the same
    new_requirements = []
    try:
        with open("requirements.txt", "r") as file:
            logging.debug("Checking requirements")
            local_reqs = file.read().splitlines()

            requirements = query_api(
                GITHUB_RAW_BASE + "/docs/requirements.txt"
            ).text.splitlines()
            for requirement in requirements:
                logging.debug("Looking for " + requirement)
                if requirement not in local_reqs and requirement != "":
                    logging.debug(requirement + " not found")
                    new_requirements.append(requirement)
                else:
                    logging.debug(requirement + " already exists in requirements.txt")

            if new_requirements != []:
                print(
                    "You may need to add the following pacakges to your requirements.txt file:"
                )
                for r in new_requirements:
                    print("%s\n" % r)
    except FileNotFoundError:
        print("requirements.txt not found")
        print(
            "The updated starter pack has moved requirements.txt out of the '.sphinx' dir"
        )
        print("requirements.txt not checked, please update your requirements manually")


def update_static_files():
    """Checks local files against remote for new and different files, downloads to '.sphinx/updates'"""
    files, paths = get_local_files_and_paths()
    new_file_list = []
    new_files = False

    for item in query_api(GITHUB_API_BASE + "/contents/docs/.sphinx").json():
        logging.debug("Checking " + item["name"])
        # Checks existing files in '.sphinx' starter pack static root for changed SHA
        if item["name"] in files and item["type"] == "file":
            index = files.index(item["name"])
            if item["sha"] != get_git_revision_hash(paths[index]):
                logging.debug("Local " + item["name"] + " is different to remote")
                download_file(item["download_url"], os.path.join(SPHINX_UPDATE_DIR, item["name"]))
                if item["name"] == "update_sp.py":
                    # Indicate update script needs to be updated and re-run
                    print("WARNING\nWARNING\nWARNING")
                    print(
                        "THIS UPDATE SCRIPT IS OUT OF DATE. YOU MAY NEED TO RUN ANOTHER UPDATE AFTER UPDATING TO THE FILE IN '.sphinx/updates'."
                    )
                    print("WARNING\nWARNING\nWARNING")
            else:
                logging.debug("File hashes are equal")
        # Checks nested files '.sphinx/**/**.*' for changed SHA (single level of depth)
        elif item["type"] == "dir":
            logging.debug(item["name"] + " is a directory")
            for nested_item in query_api(
                GITHUB_API_BASE + "/contents/docs/.sphinx" + "/" + item["name"]
            ).json():
                logging.debug("Checking " + nested_item["name"])
                if nested_item["name"] in files:
                    index = files.index(nested_item["name"])
                    if nested_item["sha"] != get_git_revision_hash(paths[index]):
                        logging.debug(
                            "Local " + nested_item["name"] + " is different to remote"
                        )
                        download_file(
                            nested_item["download_url"],
                            os.path.join(SPHINX_UPDATE_DIR, item["name"], nested_item["name"])
                        )
                # Downloads NEW nested files
                else:
                    logging.debug("No local version found of " + nested_item["name"])
                    if nested_item["type"] == "file":
                        new_file_list.append(nested_item["name"])
                        download_file(
                            nested_item["download_url"],
                            os.path.join(SPHINX_UPDATE_DIR, item["name"], nested_item["name"])
                        )
        # Downloads NEW files in '.sphinx' starter pack static root
        else:
            if item["type"] == "file":
                logging.debug("No local version found of " + item["name"])
                download_file(item["download_url"], os.path.join(SPHINX_UPDATE_DIR, item["name"]))
                if item["name"] != "version":
                    new_file_list.append(item["name"])
    # Writes return value for parent function
    if os.path.exists(os.path.join(SPHINX_UPDATE_DIR)):
        logging.debug("Files have been downloaded")
        files_updated = True
    else:
        logging.debug("No downloads found")
        files_updated = False
    # Writes return value for parent function
    if new_file_list != []:
        # Provides more information on new files
        with open("NEWFILES.txt", "w") as f:
            for entry in new_file_list:
                f.write("%s\n" % entry)
        logging.debug("Some downloaded files are new")
        new_files = True
    else:
        new_files = False
    return files_updated, new_files


# Checks git hash of a file
def get_git_revision_hash(file) -> str:
    """Get SHA of local files"""
    logging.debug("Getting hash of " + os.path.basename(file))
    return subprocess.check_output(["git", "hash-object", file]).decode("ascii").strip()


# Examines local files
def get_local_files_and_paths():
    """Identify '.sphinx' local files and paths"""
    logging.debug("Checking local files and paths")
    try:
        files = []
        paths = []
        for file in glob.iglob(SPHINX_DIR.join(".*"), recursive=True):
            files.append(os.path.basename(file))
            paths.append(file)
        for file in glob.iglob(SPHINX_DIR.join("**.*"), recursive=True):
            files.append(os.path.basename(file))
            paths.append(file)
        for file in glob.iglob(SPHINX_DIR.join("metrics/**.*"), recursive=True):
            files.append(os.path.basename(file))
            paths.append(file)
        return files, paths
    except Exception as e:
        raise Exception("ERROR executing get_local_files_and_paths: \n" + e)


# General API query with timeout and RequestException
def query_api(URL):
    """Query an API with a globally set timeout"""
    logging.debug("Querying " + URL)
    try:
        r = requests.get(URL, timeout=TIMEOUT)
        return r
    except RequestException as e:
        raise Exception("ERROR executing query_api for " + URL + ":\n" + e)


# General file download function
def download_file(url, output_path):
    """Download a file to a specified path"""
    logging.debug("Downloading " + os.path.basename(output_path))
    try:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, "wb") as file:
            file.write(query_api(url).content)
    except Exception as e:
        raise Exception("ERROR executing download_file\n" + e)


if __name__ == "__main__":
    sys.exit(main())  # Keep return code
