.. _upgrade-new-starter-pack:

Upgrade the new starter pack
============================
The documentation starter pack is regularly updated to add features and address 
bugs. You can transfer these improvements to your documentation by upgrading your 
repository's starter pack. You'll need to:

- Clone the latest version of the starter pack
- Compare key parts of the starter pack to your existing repository 
- Transfer or delete relevant changes 
- Test that the documentation builds correctly with the new changes

This guide assumes your project runs on an extension-based version of the starter 
pack. If this is not the case, refer to the guide on 
:ref:`migrating from the pre-extension version <migrate-from-pre-extension>`.
One sign that your docs may be on the pre-extenstion version is having the 
`build_requirements.py` file in the repository.

.. note::
    This upgrade guide assumes your existing project has minimal customizations, 
    and the repository structure closely mirrors the starter pack's. Depending 
    on your customizations, you may need to take extra steps when upgrading. 

Clone the starter pack repository
---------------------------------
Open a terminal and clone the starter pack's GitHub repository:

.. code-block::

    git clone https://github.com/canonical/sphinx-docs-starter-pack.git

Confirm that the starter pack's documentation and your own build with no errors.

.. important::
   Verify that your documentation still builds correctly after each key step. This 
   makes it easier to identify causes of build errors.

Update the `Makefile`, `conf.py`, and `.readthedocs.yaml` files
----------------------------------------------------------------
A starter pack upgrade usually includes some changes to these files. You'll need 
to merge the changes you want to keep to the new ones from the starter pack. The 
recommended approach is to copy the customizations in your existing files to 
the starter pack files and then replace the existing files with the starter pack's. 

The changes to be made vary between projects and upgrades. Therefore, this guide 
cannot be overly prescriptive.

Update `conf.py`
~~~~~~~~~~~~~~~~~
Rename your `conf.py` file to avoid overwriting it, and copy the starter pack's 
version to the same location. Use a graphical diff tool such as `Kompare <https://apps.kde.org/kompare/>`_
or `meld <https://meldmerge.org/>`_ to compare the old and new file and make the 
following changes:

-   Copy your standard project details to the new `conf.py` file. These include:

    -   Project and author names 
    -   Ignored links
    -   Social links, etc.

-   Verify that the `/static` and `/templates` folders are located at the locations
    specified by `html_static_path` and `templates_path`, respectively, in the 
    new `conf.py` file. These should not be inside the `/.sphinx` folder.

For other customizations, consider need and compatibility before copying them to 
the new file. If it's not obvious whether you should copy over a customization
or include a new change, reach out to `Canonical's documentation team <https://matrix.to/#/#documentation:ubuntu.com>`_.

Update `Makefile` and `.readthedocs.yaml`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Depending on the version of your starter pack, the new `Makefile` and `.readthedocs.yaml`
files may have few or no changes. Apply the same approach you used for `conf.py` 
to merge your customizations into the new files. 

If there are no project-specific customizations in your files but there are changes 
in the new ones, you can just overwrite your existing files with the new ones.

Update the `/.sphinx` folder
-----------------------------
In addition to the docs above, the `/.sphinx` folder is also likely to have some
changes in each upgrade. These files are not intended to be modified by users. 

Unless you intentionally customized files in this folder, you can simply delete 
your existing `/.sphinx` folder and replace it with the starter pack's. If you 
have any modifications in your existing `/.sphinx` folder, it is recommended that 
they transfer them out.

Review less frequently changed files
------------------------------------
Some files in the starter pack may be updated less frequently, but it's a good idea 
to review them during each upgrade and determine if there are relevant changes:

-   Review `requirements.txt`: If there are any updates, and your existing file 
    has no repository-specific requirements, you can simply replace the existing 
    file with the new one. If you added requirements based on your customizations 
    be sure to include them, e.g., `sphinxext-rediraffe` if you use rediraffe to 
    handle redirects.

-   Review the workflows in the `/.github` folder: If there are changes in the 
    following workflows, replace the existing files with the new ones. The starter 
    pack may have more workflows included. You'll need to decide whether you need 
    the additional workflows or not: 

    -   Automatic doc checks
    -   CLA (contributor license agreement) check
    -   Check for removed URLs
    -   Markdown style check (only required for docs using markdown)

-   Review and transfer any additions in the new `.gitignore` file to the existing
    one.

Test the build and run local CI checks
--------------------------------------
Try building the docs locally and check the terminal output for errors::

    make run

To ensure the upgraded docs will pass CI checks when you make a pull request, run 
the following commands and fix any errors reported:

-   ``make spelling``
-   ``make linkcheck``
-   ``make woke``
-   ``make lint-md`` (if you included the `markdown-style-checks` workflow)

Troubleshooting build errors
----------------------------
There is always the possibility of encountering build errors. Common causes 
include:

-   Incorrect file locations or file paths 
-   Incompatible requirements in the new requirements file 
-   Missing customizations 
-   Cached build files

When troubleshooting use the ``make clean`` command to ensure cached versions of 
build files are not reused.

Clean up 
--------
There may be files that need to be deleted after the upgrade such as starter-pack 
specific files or files that have been replaced with newer versions: 

-   If you haven't done it already, delete the copies of `conf.py`, `Makefile`, and 
    `/.readthedocs.yaml` that were renamed and replaced. 
-   If you did not strictly follow this guide for this or previous upgrades, it's 
    possible that you have some starter pack-specific files in your repository. 
    These can be deleted unless you repurposed them for your docs: 

    -   `.github/pull_request_template.md`
    -   `.github/workflows/sphinx-python-dependency-build-checks.yml`
-   The following are starter pack specific files and should be deleted:

    -   `docs/reuse/links.txt`
    -   `docs/reuse/mermaid.txt`
    -   `docs/reuse/substitutions.txt`
    -   `docs/reuse/substitutions.yaml`
    -   `.github/CODEOWNERS` (starter pack's version)
    -   `.github/workflows/test-starter-pack.yml`
