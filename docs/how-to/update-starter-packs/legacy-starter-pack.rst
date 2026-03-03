.. meta::
   :description: Learn how to update Sphinx starter pack projects that don't yet use the canonical-sphinx extension.

.. _update-legacy-starter-pack:

Update the legacy starter pack 
==============================

This guide outlines the steps required to migrate a documentation project from the legacy Sphinx Documentation Starter Pack (*pre-extension* version) to the latest version that adopts the ``canonical-sphinx`` Sphinx extension.

The extension-based documentation starter pack provides a set of features and configurations that are common across Canonical documentation projects. Key components, such as configuration and styling, are loaded as an add-on to your documentation project. It can significantly reduce maintenance concerns when managing your documentation.

.. note::
   If ``canonical-sphinx`` is included under ``extensions`` in your `conf.py`, 
   you are already using an extension-based starter-pack. Follow the guide on 
   :ref:`updating the new starter pack <update-new-starter-pack>`.

Update to the last pre-extension version
----------------------------------------

To ensure a smooth migration, update your documentation project to use the last pre-extension version of the Sphinx Documentation Starter Pack. This update ensures that your project is using the latest features and configurations available, minimising the changes required during the migration.

You can find the release tag and branch for this version in the following links:

* `pre-extension branch <https://github.com/canonical/sphinx-docs-starter-pack/tree/pre-extension>`_
* `pre-extension release tag <https://github.com/canonical/sphinx-docs-starter-pack/releases/tag/pre-extension>`_


Set up a new project
--------------------

1. Back up all existing files in your original documentation project. For example, you can rename the original ``docs/`` folder to ``docs_backup/``.

   .. warning::

      If you proceed in the same directory, the following steps will overwrite some of the configuration files in the original project.

2. Follow the steps in the :ref:`initial-setup` guide to initialise an empty project with the extension-based starter pack, at the original file path.

3. Ensure the following files are at the root of your repository:

   - ``.github/workflows/*``

4. Ensure the following files are moved to their original paths in the project. These files are defaulted to the repository root, but may have be changed upon project needs: 

   - ``.gitignore``
   - ``.readthedocs.yml``

5. Validate the project setup locally by running ``make run`` in the new project directory.


Migrate source files
--------------------

The documentation starter pack has undergone breaking changes with the introduction of the ``canonical-sphinx`` extension. This section guides you through:

- Configuration file changes
- Extension dependencies
- Documentation source migration

For a complete list of the structural changes, refer to the `directory-structure-change`_ section.

Sphinx configuration
~~~~~~~~~~~~~~~~~~~~~

A significant change in the new starter pack is the organisation of the configuration files, summarised in the following table:

.. list-table::
   :widths: 20 40 40
   :header-rows: 1

   * - Configuration file
     - Pre-extension 
     - Extension-based
   * - ``conf.py``
     - Common configurations shared by all starter pack projects
     - Project-specific configurations
   * - ``custom_conf.py``
     - Project-specific configuration
     - Merged into ``conf.py`` and removed

In the new starter pack, many common configurations are provided by the extension and are loaded automatically when building the documentation. ``docs/conf.py`` is the only configuration file, and it contains all project-specific configuration. Sensible defaults are set for general configuration by inclusion of the `canonical-sphinx` extension.

Ensure that all the previous changes in the original ``custom_conf.py`` file are copied to the new ``conf.py`` file.  

Dependencies
~~~~~~~~~~~~

If your project requires additional extensions beyond the default list, add the extension list to the new project in ``docs/requirements.txt``.

Documentation source files
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Remove the starter pack's documentation files (``index.rst`` and any files in the ``docs/**/*`` sub-directory).

2. Copy all documentation source files from your original project to the new project, keeping their original structure. These file may include but are not limited to:

   - ``.md`` 
   - ``.rst`` 
   - ``.txt``
   - ``.json``
   - images
   - scripts

3. Validate the migration by running ``make run``.

Apply customisation
-------------------

If your projects have custom configurations or styles, ensure that you identify and apply these changes to the new documentation project.

For general information on customising the extension configuration, see :ref:`configure-your-project`.

Static resources
~~~~~~~~~~~~~~~~

The extension provides a set of static resources, such as images, fonts, CSS files, and HTML templates, that are used to style the documentation for Canonical-branded design. These resources are bundled with the extension and are no longer provided as source files in the new starter pack.

If you have customised any of these resources in the original project, you need to manually migrate these changes to the new project. 

For example, if you added customised styling in the original ``.sphinx/_static/custom.css`` file, follow the steps:

1. Compare the changes between your customised file and the `default CSS file provided by the extension <https://github.com/canonical/canonical-sphinx/blob/main/canonical_sphinx/theme/static/custom.css>`_. This comparison helps you identify the changes that need to be migrated to the new project.
2. Create a new CSS file under ``docs/.sphinx/_static``. You can choose any other file location in the project directory, but it's recommended to keep the file structure similar to the original project.
3. Copy the additions and changes to the new empty file.
4. In the ``conf.py``, add the new files into the pre-defined ``html_css_files`` list variable to overwrite the default settings.
5. Build the documentation to verify that the customised styling is applied correctly.


.. _directory-structure-change:

Directory structure changes
----------------------------

After you migrate to the extension, some directories and files are either deleted from the project or moved to a new location.

Assuming that all previous documentation files were in the ``docs/`` sub-directory, the following list illustrates the changes in the directory structure after the migration.

.. code-block:: text

    .
    ├── .github
    │   └── workflows
    │       ├── automatic-doc-checks.yml
    │       └── markdown-style-checks.yml
    ├── .sphinx                     # moved to `docs/.sphinx`
    │   ├── fonts                   # removed, files are part of the extension
    │   │   ├── Ubuntu-B.ttf
    │   │   ├── ubuntu-font-licence-1.0.txt
    │   │   ├── UbuntuMono-B.ttf
    │   │   ├── UbuntuMono-RI.ttf
    │   │   ├── UbuntuMono-R.ttf
    │   │   ├── Ubuntu-RI.ttf
    │   │   └── Ubuntu-R.ttf
    │   ├── images                  # removed, files are part of the extension
    │   │   ├── Canonical-logo-4x.png
    │   │   ├── front-page-light.pdf
    │   │   ├── front-page.png
    │   │   └── normal-page-footer.pdf
    │   ├── _static                 # removed, files are part of the extension
    │   │   ├── 404.svg
    │   │   ├── custom.css
    │   │   ├── favicon.png
    │   │   ├── footer.css
    │   │   ├── footer.js
    │   │   ├── furo_colors.css
    │   │   ├── github_issue_links.css
    │   │   ├── github_issue_links.js
    │   │   ├── header.css
    │   │   ├── header-nav.js
    │   │   └── tag.png
    │   ├── _templates              # removed, files are part of the extension
    │   │   ├── sidebar
    │   │   │   └── search.html
    │   │   ├── 404.html
    │   │   ├── base.html
    │   │   ├── footer.html
    │   │   ├── header.html
    │   │   └── page.html
    │   ├── build_requirements.py   # removed
    │   ├── get_vale_conf.py
    │   ├── latex_elements_template.txt     # removed, now part of the extension
    │   ├── pa11y-ci.json           # renamed to `pa11y.json`
    │   └── spellingcheck.yaml
    ├── metrics                     # removed
    │   └── scripts                 
    │       ├── build_metrics.sh   
    │       └── source_metrics.sh   
    ├── reuse                       # moved to `docs/reuse`
    │   └── links.txt
    ├── .custom_wordlist.txt        # moved to `docs/.custom_wordlist.txt`
    ├── .gitignore
    ├── .readthedocs.yaml
    ├── .wordlist.txt               # moved to `docs/.sphinx/.wordlist.txt`
    ├── .wokeignore                 # removed, check replaced by Vale
    ├── conf.py                     # removed, now part of the extension
    ├── custom_conf.py              # renamed and moved to `docs/conf.py`
    ├── doc-cheat-sheet-myst.md     # moved to `docs/doc-cheat-sheet-myst.md`
    ├── doc-cheat-sheet.rst         # moved to `docs/doc-cheat-sheet.rst`
    ├── index.rst                   # moved to `docs/index.rst`
    ├── init.sh                     # removed
    ├── make.bat                    # removed
    ├── Makefile                    # moved to `docs/Makefile`
    ├── Makefile.sp                 # removed
    └── readme.rst                  # renamed to `README.rst`

