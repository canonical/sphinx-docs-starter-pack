#! /usr/bin/env python

# Initial update script for the starter pack.
#
# Requires some manual intervention, but makes identifying updates and differences easier.

import requests
import os
import glob
import subprocess

files = []
paths = []

for file in glob.iglob(".sphinx/.*", recursive=True):
    files.append(os.path.basename(file))
    paths.append(file)
for file in glob.iglob(".sphinx/**.*", recursive=True):
    files.append(os.path.basename(file))
    paths.append(file)
for file in glob.iglob(".sphinx/metrics/**.*", recursive=True):
    files.append(os.path.basename(file))
    paths.append(file)

def main():

    # Check current version
    with open(".sphinx/version") as f:
        current_version = f.read()

    url = ("https://api.github.com/repos/secondskoll/sphinx-docs-starter-pack/releases/latest")
    r = requests.get(url)

    # Check curent release version
    try:
        current_release = r.json()["tag_name"]
    except:
        raise Exception("Update failed. You may be rate limited. Current implementation is done as an unauthenticated user.")

    # Perform actions only if versions are different
    if current_version != current_release:
        print(f"Starter pack is out of date.\n")

        # Identify and download '.sphinx' dir files to '.sphinx/update' 
        files_updated, new_files = update_static_files()

        # Write new version to file to '.sphinx/update'
        version = requests.get("https://raw.githubusercontent.com/secondskoll/sphinx-docs-starter-pack/main/docs/.sphinx/version").text
        os.makedirs(os.path.dirname(".sphinx/update/version"), exist_ok=True)
        open(".sphinx/update/version", 'wt').write(version)
    
        # Provide changelog to identify other significant changes
        changelog = requests.get("https://raw.githubusercontent.com/secondskoll/sphinx-docs-starter-pack/main/CHANGELOG.md")
        try:
            new, old = changelog.text.split("## " + current_version)
            print(new)
        except:
            raise Exception("Current version not identified. Please examine the CHANGELOG and update manually.")



        # Provide information on any files identified for updates
        if files_updated == True:
            print("Differences have been identified in static files.")
            print("Updated files have been downloaded to '.sphinx/update'.")
            print("Move these files into your '.sphinx/' directory.")

        # Provide information on NEW files
        if new_files == True:
            print(f"\nNOTE: New files have been downloaded: See 'NEWFILES.txt' for details.")

    else:
        print("This version is up to date.")

    # Check requirements are the same
    new_requirements = []
    with open("requirements.txt", "r") as file:
        local_reqs = file.read().splitlines()

        requirements = requests.get("https://raw.githubusercontent.com/secondskoll/sphinx-docs-starter-pack/main/docs/requirements.txt").text.splitlines()
        for requirement in requirements:
            if requirement not in local_reqs:
                new_requirements.append(requirement)

        if new_requirements != []:
            print("You may need to add the following pacakges to your requirements.txt file:")
            for r in new_requirements:
                print("%s\n" % r)

def update_static_files():

    url = ("https://api.github.com/repos/canonical/sphinx-docs-starter-pack/contents/docs/.sphinx")
 
    new_files = []

    r = requests.get(url)
    for item in r.json():


        # Checks existing files in '.sphinx' starter pack static root for changed SHA 
        if item["name"] in files and item["type"] == "file":
            index = files.index(item["name"])
            if item["sha"] != get_git_revision_hash(paths[index]):
                download = requests.get(item["download_url"])
                open(".sphinx/update/" + item["name"], 'wb').write(download.content)
                if item["name"] == "update_sp.py":
                    # Indicate update script needs to be updated and re-run
                    raise Exception("THIS UPDATE SCRIPT IS OUT OF DATE. YOU MAY NEED TO RUN ANOTHER UPDATE AFTER UPDATING TO THE FILE IN '.sphinx/updates'.")

        # Checks nested files '.sphinx/**/**.*' for changed SHA (single level of depth)
        elif item["type"] == "dir":
            url = ("https://api.github.com/repos/canonical/sphinx-docs-starter-pack/contents/docs/.sphinx" + "/" + item["name"])
            r2 = requests.get(url)
            for nested_item in r2.json():
                if nested_item["name"] in files:
                    index = files.index(nested_item["name"])
                    if nested_item["sha"] != get_git_revision_hash(paths[index]):
                        download = requests.get(nested_item["download_url"])
                        os.makedirs(os.path.dirname(".sphinx/update/" + item["name"] + "/" + nested_item["name"]), exist_ok=True)
                        open(".sphinx/update/" + item["name"] + "/" + nested_item["name"], 'wb').write(download.content)
                # Downloads NEW nested files
                else:
                    if nested_item["type"] == "file":
                        new_files.append(nested_item["name"])
                        download = requests.get(nested_item["download_url"])
                        os.makedirs(os.path.dirname(".sphinx/update/" + item["name"] + "/" + nested_item["name"]), exist_ok=True)
                        open(".sphinx/update/" + item["name"] + "/" + nested_item["name"], 'wb').write(download.content)

        # Downloads NEW files in '.sphinx' starter pack static root
        else:
            if item["type"] == "file":
                new_files.append(item["name"])
                download = requests.get(item["download_url"])
                os.makedirs(os.path.dirname(".sphinx/update/" + item["name"]), exist_ok=True)
                open(".sphinx/update/" + item["name"], 'wb').write(download.content)

    # Writes return value for parent function
    if os.path.exists(".sphinx/update/"):
        files_updated = True
    else:
        files_updated = False


    # Writes return value for parent function
    if new_files != []:
        # Provides more information on new files
        with open("NEWFILES.txt", 'w') as f:
            for entry in new_files:
                f.write("%s\n" % entry)
        new_files = True
    else:
        new_files = False

    return files_updated, new_files


# Checks git hash of a file
def get_git_revision_hash(file) -> str:
    return subprocess.check_output(['git', 'hash-object', file]).decode('ascii').strip()

if __name__ == "__main__":
    main()
