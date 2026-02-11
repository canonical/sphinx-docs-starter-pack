.. _upgrade-starter-pack:

Upgrade to newer version of starter pack
========================================
The documentation starter pack is regularly updated to add features and address 
bugs. To transfer these improvements to your documentation's starter pack, you'll 
need to go through several manual steps.

This guide takes you through the main steps of upgrading a documentation's starter 
pack. It assumes you already have a project that runs on an extension-based 
version of the starter pack. If this is not the case, checkout this guide on 
:ref:`migrating from the pre-extension version <migrage-from-pre-extension>`.

Clone the starter pack repository
---------------------------------
Open a terminal and clone the starter pack's GitHub repository:

.. code-block::

    git clone https://github.com/canonical/sphinx-docs-starter-pack.git

This will clone the main branch, which will have the latest updates and may include 
experimental features. For the latest stable version, clone the ``dev`` branch 
instead:

.. code-block::

    git clone -b dev https://github.com/canonical/sphinx-docs-starter-pack.git

Confirm that the starter pack's documentation and your own build with no errors.

.. note::

   Verify that the documentation still builds locally after each key step to make 
   it easier to identify the causes of build errors.

Replace the `Makefile`, `conf.py`, and `.readthedocs.yaml` files
----------------------------------------------------------------
A starter pack upgrade usually includes some changes to these files. You'll need 
to merge the changes you want to keep to the new ones from the starter pack. The 
recommended approach is to copy the customizations in your existing files to 
the starter pack files and then replace the existing files with the starter pack's. 

The changes to be made vary between projects and upgrades. Therefore, this guide 
cannot be overly prescriptive.

Replace `conf.py`
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

-   For less generic customizations, consider need and compatibility before copying
    them to the new file.

If it's not obvious whether you should copy over certain customizations or include 
a new change, reach out to `Canonical's documentation team <https://matrix.to/#/#documentation:ubuntu.com>`_.

Replace `Makefile` and `.readthedocs.yaml`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Depending on the version of your starter pack, the new `Makefile` and `.readthedocs.yaml`
files may have few or no changes. Use the same approach you used for `conf.py` to
merge the new files with any customizations in your own repository. If there are 
no project-specific customizations in your files, overwrite them with the new ones. 

Replace the `./sphinx` folder
-----------------------------
In addition to the docs above, the `./sphinx` folder is also likely to have some
changes in each upgrade. These files are not intended to be modified by users of
the starter pack. 

Delete your existing `./sphinx` folder and replace it with one from the starter pack.

Additional changes
------------------
Replace the `requirements.txt` file. Just as with the first three files, take note 
of any repository-specific requirements not available in the new file and add them, 
e.g., `sphinxext-rediraffe` if you use rediraffe to handle redirects. 

In newer versions of the starter pack, the requirements file is at the root of 
the `/docs` folder, but some projects prefer a different structure. Note that such 
differences could result in build errors if not accounted for in the Makefile.

Replace the following workflows in the `/.github` folder:
-   Automatic doc automatic-doc-checks
-   CLA (contributor license agreement) check
-   Check for removed URLs

If your documentation has markdown files, you can also copy or replace the markdown
style check.

Test the build
--------------
Try building the docs and check the terminal output for any errors::

    make run

Troubleshooting build errors
----------------------------
There is always the possibility of encountering build errors. Common causes 
include:

-   Incorrect file locations or file paths 
-   Incompatible requirements in the new requirements files 
-   Missing customizations 

If you encounter a build error, start by going through the terminal output and try
to narrow down the cause by looking at the affected files. Errors can also be the 
result of interrupted or unstable internet connections or upstream changes. Use 
the ``make clean`` command while troubleshooting to ensure cached versions of files
are not used in new builds.

Clean up 
--------
There may be files that need to be deleted after the upgrade such as starter-pack 
specific files or files that have been replaced with newer versions: 

-   If you haven't done it already, delete the copies of `conf.py`, `Makefile`, and 
    `./readthedocs.yaml` that were renamed and replaced. 
-   If you did not strictly follow this guide for this or previous upgrades, it's 
    possible that you have some starter pack-specific files in your repository. 
    These can be deleted unless you actually use them for your docs: 

    -   `pull_request_template.md`
    -   `sphinx-python-dependency-build-checks.yml`
    -   `reuse/links.txt`
    -   `mermaid.txt`
    -   `substitutions.txt`
    -   `substitutions.yaml`
    -   `CODEOWNERS`

Run local CI checks
-------------------
To ensure the upgrade will pass CI checks when you make a pull request, run the 
following commands and fix any errors reported:

-   ``make spelling``
-   ``make linkcheck``
-   ``make woke``
-   ``make lint-md`` (if you included the `markdown-style-checks` workflow)

