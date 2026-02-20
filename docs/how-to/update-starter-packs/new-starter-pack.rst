.. meta::
   :description: Learn how to update Sphinx starter pack projects that use the ``canonical-sphinx`` extenstion.

.. _update-new-starter-pack:

Update the new starter pack
===========================

The documentation starter pack is regularly updated to add features and address 
bugs. You can transfer these improvements to your project by following these steps:

- Clone the latest version of the starter pack
- Compare key files and directories in the starter pack to your project 
- Transfer or delete relevant changes 
- Confirm that your project builds correctly with the new changes

This guide assumes your project has minimal customizations, and the repository 
structure closely mirrors the starter pack's. Depending on your customizations, 
you may need to take extra steps when upgrading. 

.. note::
   If ``canonical-sphinx`` is not included under ``extensions`` in your `conf.py`, 
   your project is not on an extension-based starter-pack. Follow the guide on 
   :ref:`updating a legacy starter pack project <update-legacy-starter-pack>`.

Clone the starter pack repository
---------------------------------
If you don't have a clean, local copy of the starter pack, clone it:

.. code-block::

    git clone https://github.com/canonical/sphinx-docs-starter-pack.git

Confirm that both the starter pack's documentation and your project build with 
no errors.

.. important::
   Verify that your project still builds correctly after each key step. This 
   makes it easier to identify causes of build errors.

Update the configuration and build files
----------------------------------------
New starter pack versions often change the default configuration files. You'll 
need to merge your project files with the config files from the new starter pack.
The recommended approach is to copy the customizations in your project to the starter 
pack's config files and then replace your project's config files with the starter 
pack's. 

The changes to be made vary between projects and upgrades. Therefore, this guide 
cannot be overly prescriptive.

``conf.py``
~~~~~~~~~~~
Rename your `conf.py` file to avoid overwriting it, and copy the starter pack's 
version to the same location. Use a graphical diff tool such as `Kompare <https://apps.kde.org/kompare/>`_
or `meld <https://meldmerge.org/>`_ to compare the old and new file and make the 
following changes:

-   Copy your standard project details to the new `conf.py` file. These include:

    -   Project and author names 
    -   Ignored links
    -   Social links, etc.

-   Verify that the `/static` and `/templates` directories are located at the locations
    specified by `html_static_path` and `templates_path`, respectively, in the 
    new `conf.py` file. These should not be inside the `/.sphinx` directory.

For other customizations, consider need and compatibility before copying them to 
the new file. If it's not obvious whether you should copy over a customization
or include a new change, reach out to `Canonical's documentation team <https://matrix.to/#/#documentation:ubuntu.com>`_.

``Makefile`` and ``.readthedocs.yaml``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Depending on the version of your project's starter pack, the new `Makefile` and `.readthedocs.yaml`
files may have few or no changes. Apply the same approach you used for `conf.py` 
to merge your customizations into the new files. 

If there are no project-specific customizations in your files but there are changes 
in the new ones, you can just overwrite your existing files with the new ones.

Update the ``/.sphinx`` directory
---------------------------------
In addition to the docs above, the `/.sphinx` directory is also likely to have some
changes in each upgrade. These files are not intended to be modified by users. 

Unless you intentionally customized files in this directory, you can simply delete 
your project's `/.sphinx` directory and replace it with the starter pack's. If there 
are modifications in your project's `/.sphinx` directory, it is recommended that 
they transfer them out.

Review the remaining files
--------------------------
Some files in the starter pack may be updated less frequently, but it's a good idea 
to review them during each upgrade and determine if there are relevant changes:

-   Review `requirements.txt`: If there are any updates, and your project's file 
    has no repository-specific requirements, you can overwrite the existing file 
    with the new one. If you added requirements based on your customizations be 
    sure to include them, e.g., `sphinxext-rediraffe` if you use rediraffe to 
    handle redirects.

-   Review the workflows in the `/.github` directory: If there are changes in the 
    following workflows, replace the existing files with the new ones. The starter 
    pack will have other workflows as well, but you'll need to decide whether your 
    project needs them or not: 

    -   Automatic doc checks
    -   CLA (contributor license agreement) check
    -   Check for removed URLs
    -   Markdown style check (only required for docs using markdown)

-   Review and transfer any necessary changes in the new `.gitignore` file to your 
    project.

Build and test
--------------
Try building the docs locally and check the terminal output for errors::

    make run

To ensure the upgraded docs will pass CI checks when you make a pull request, run 
the following commands and fix any errors reported:

-   ``make spelling``
-   ``make linkcheck``
-   ``make woke``
-   ``make lint-md`` (if you included the `markdown-style-checks` workflow)

Troubleshooting errors
----------------------
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

-   If you haven't done so already, delete the copies of `conf.py`, `Makefile`, and 
    `/.readthedocs.yaml` that were renamed and replaced. 
-   If you did not strictly follow this guide for this or previous upgrades, it's 
    possible that you have some starter pack-specific files in your project. 
    These files can be safely deleted: 

    -   `.github/pull_request_template.md`
    -   `.github/workflows/sphinx-python-dependency-build-checks.yml`
    -   `.github/CODEOWNERS`
    -   `.github/workflows/test-starter-pack.yml`
    
-   These files can be deleted as long as they are not being used in your docs:

    -   `docs/reuse/links.txt`
    -   `docs/reuse/mermaid.txt`
    -   `docs/reuse/substitutions.txt`
    -   `docs/reuse/substitutions.yaml`
