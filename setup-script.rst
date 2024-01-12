:orphan:

Setup script
============

An alternative to the manual setup steps is to use a setup script to automatically initialise your repository using the starter pack. This script is provided as a beta feature: use it with care and check all changes manually before committing them to your repository.

Prerequisites
~~~~~~~~~~~~~

Before you begin, ensure you have the following:

* A GitHub repository where you want to host your documentation, cloned to your local machine. The recommended approach is to host the documentation alongside your code in a `docs` folder. But a standalone documentation repository is also an option; in this case, start with an empty repository.
* Git and Bash installed on your system.

Initialise your documentation repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``init.sh`` Bash script is used to initialise your repository with the starter pack content. It adds all the files to your repository that are needed to get started with Sphinx documentation.

To use the script, follow these steps:

* Copy ``init.sh`` to your repository's root directory.
* Run the script: ``./init.sh``
* Enter the installation directory when prompted. For standalone repositories, enter ".". For documentation alongside code, enter the folder where your documentation are e.g. "docs".

This Bash script does the following:

* Clones the starter pack GitHub repository
* Creates the specified installation directory if necessary
* Updates working directory paths in workflow files, and updates configuration paths in the ``.readthedocs.yaml`` file
* Copies and moves contents and ``.github`` files from the starter pack to the installation directory
* Deletes the cloned repository when it's done

When the script completes, review all changes before committing, then commit your changes.

