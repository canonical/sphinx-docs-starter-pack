.. _upgrade-starter-pack:

Upgrade to newer version of starter pack
========================================
The documentation starter pack is regularly updated to add features and address 
errors, bugs, and more. It's a good idea to ensure your documentation is always 
running on a relatively recent version of the same.

This guide takes you through the main steps of upgrading your starter pack. It 
assumes that you are already have an active project that runs on an extension-based 
version of the starter pack. If this is not the case, checkout this guide on :ref:`migrating from the pre-extension version <migrage-from-pre-extension>`.

Clone the starter pack repository
---------------------------------
Open a terminal and clone the starter pack's GitHub repository:

.. code-block::

    git clone https://github.com/canonical/sphinx-docs-starter-pack.git

By default, this will clone the main branch which will have the latest updates,
and may include some experimental features. For the latest stable version, clone
the dev branch instead:

.. code-block::

    git clone -b dev https://github.com/canonical/sphinx-docs-starter-pack.git

Confirm that the starter pack's documentation and your own build with no errors.

Replace the `Makefile`, `conf.py`, and `.readthedocs.yaml` files
----------------------------------------------------------------
The exact changes that need to be made in these three files will vary from one
upgrade to the next, therefore, this guide cannot be overly prescriptive. However,
the goal is to transfer the functional changes in the new version of the files 
to your documentation without affecting your customizations. 

The recommended approach is to copy the customizations in your existing files to 
the starter pack's version, then replace the existing version of the file with 
the new one.

Replace `conf.py`
~~~~~~~~~~~~~~~~~
Rename the existing `conf.py` file and copy the version in the starter pack into
your docs repo. Use a graphical diff tool such as `Kompare <https://apps.kde.org/kompare/>`_
or `meld <https://meldmerge.org/>`_ to compare the two versions of `conf.py` and 
make the following changes:

-   Copy typical project specific details into new `conf.py file`. These include:

    -   Project and author names 
    -   Ignored links
    -   Social links, etc.

-   Check the file paths for the `/templates` and `/static` folders and ensure 
    the folders are in the file paths indicated in the new `conf.py` file and 
    not inside the `/.sphinx` folder.

-   For less generic customizations, consider need and compatibility before copying
    them to the new file.

If it's not obvious whether you should copy over certain customizations, reach
out to `Canonical's documentation team <https://matrix.to/#/#documentation:ubuntu.com>`_.

.. note::

    It's recommended to regularly check the local build with each major modification to 
    confirm that it's still able to build correctly.

Replace `Makefile` and `.readthedocs.yaml`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The `Makefile` and `.readthedocs.yaml` file typically have few or no customizations.
If there are no project-specific customizations in these files, replace the 
existing versions with the new ones from the starter pack.

Replace the `./sphinx` folder
-----------------------------
In addition to the above three docs, the `./sphinx` folder is likely to have some
changes in each upgrade. These files are not intended to be modified by users of
the starter pack. 

Therefore, simply delete your existing `./sphinx` folder and 
replace it with one from the starter pack.

Additional changes
------------------
Replace the `requirements.txt`. Just as with the configuration file, take note 
of any repo-specific requirements that are not available in the new file and add
them, e.g., `sphinxext-rediraffe` if you use rediraffe to handle redirects. 

In the new versions of the starter pack, the requirements file is placed at the 
root of the `/docs` folder.

Replace the following workflows in the `/.github` folder:
-   Automatic doc automatic-doc-checks
-   CLA (contributor license agreement) check
-   Check for removed URLs

If your documentation has markdown files, you can also copy or replace the markdown
style check.

Test the build
--------------
Try building the docs and check the logs for any errors::

    make run

Troubleshooting build errors
----------------------------
Whether you use the script or the manual process, there is always the possibility 
of encountering build errors. Common causes for build errors include:

-   Incorrect file locations or file paths 
-   Incompatible requirements in the new requirements files 
-   Missing customizations 

If you encounter a build error, start by going through the terminal logs and try
to narrow down the cause by looking at the affected files. Errors can also be the 
result of interrupted or unstable internet connections or upstream changes. Use 
the ``make clean`` command while troubleshooting to ensure cached versions of files
are not used in new builds.

Clean up 
--------
There may be files that need to be deleted after the upgrade process, especially
if you use the manual process. These may be starter-pack specific files, or files 
that have been replaced: 

-   If you haven't done it already, deleted the copies of `conf.py`, `Makefile`, and 
    `./readthedocs.yaml` that were renamed and replaced in your docs repo. 
-   If you didn't follow this workflow for this or previous upgrades, it's possible 
    that you have some starter pack-specific files in your repository, and these
    can be deleted unless you intentionally use them for your docs. These include:

    -   `pull_request_template.md`
    -   `sphinx-python-dependency-build-checks.yml`
    -   `reuse/links.txt`
    -   `mermaid.txt`
    -   `substitutions.txt`
    -   `substitutions.yaml`
    -   `CODEOWNERS`
