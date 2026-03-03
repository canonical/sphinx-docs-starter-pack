.. _set-up-a-new-project:

===================================
Set up a new project
===================================

This page contains a short guide on how to set up and use the starter pack.

.. _initial-setup:

Copy the starter pack
=====================

If you're starting a new project, `copy the starter pack as a template repository <https://github.com/new?template_name=sphinx-docs-starter-pack&template_owner=canonical>`__.

If you're creating documentation for a Canonical project, set the owner to **canonical**.

If you're adding documentation to an existing software project, copy the following files from the starter pack repository into your project:

* the entire :file:`docs` directory
* :file:`.readthedocs.yaml` (configuration for the building on Read the Docs)
* the entire :file:`.github/workflows` directory


.. _remove-unneeded-files:

Remove the unneeded files
=========================

Next, review the starter pack files and remove those that could interfere with your project.

Remove the files that can't be reused:

- :file:`CONTRIBUTING.md`
- :file:`.github/CODEOWNERS`
- :file:`.github/workflows/test-starter-pack.yml`

Review and remove the GitHub workflows in ``.github/workflows/`` that your project might not need:

- :file:`cla-check.yml` verifies whether contributors have signed the `Canonical License Agreement <https://canonical.com/legal/contributors>`_. All Canonical projects require this check, so if you're adding docs to an existing Canonical project that already has it, remove this workflow.
- :file:`sphinx-python-dependency-build-checks.yml` verifies Python dependencies for the documentation system. If your project has its own dependency checks, remove this workflow.
- :file:`markdown-style-checks.yml` runs the built-in Markdown linter. If your project already validates its Markdown files, remove this workflow.


Build and run the local server
==============================

Building the documentation requires ``make``, ``python3``, ``python3-venv``, ``python3-pip``.

In :file:`docs`, run::

    make run

This creates and activates a virtual environment in :file:`docs/.sphinx/venv`, builds the documentation and serves it at :literalref:`http://127.0.0.1:8000/`.

The server watches the source files, including :file:`docs/conf.py`, and rebuilds automatically on changes.


Edit content
==============

Now that you've verified you can build and run the sample starter pack documentation, you can replace it with your own content.

The landing page is :file:`docs/index.rst`. Other pages are under one of the sub-directories under :file:`docs/`.

The navigation menu structure is set by ``.. toctree::`` directives. These directives define the hierarchy of included content throughout the documentation.
The :file:`index.rst` page's ``toctree`` block contains the top level navigation, which by default is the `Diátaxis`_ documentation structure.

To add a new page to the documentation:    

1. Create a new file in the `docs/` folder. For example, to create a new **Reference** page, create a document under `docs/reference/` directory called :file:`settings.rst`, insert the following |RST|-formatted heading ``Settings`` at the beginning, and then save the file:

   .. code-block:: rest
      :caption: reStructuredText title example

         Settings
         ========

   If you prefer to use Markdown (MyST) syntax instead of |RST|, you can create a Markdown file. For example, :file:`settings.md` file with the following Markdown-formatted heading at the beginning:

   .. code-block:: markdown
      :caption: Markdown title example
         
         # Settings

2. Add the new page to the Navigation Menu: open the :file:`docs/reference/index.rst` file or another file where you want to nest the new page; at the bottom of the file, locate the ``toctree`` directive and add a properly indented line containing the relative path (without a file extension) to the new file created in the first step. For example, ``settings``.

   The ``toctree`` block will now look like this:

   .. code-block:: rest
         
         .. toctree::
            :hidden:
            :maxdepth: 2

            Documentation checks <automatic_checks>
            style-guide
            style-guide-myst
            settings

The documentation will now show the new page added to the navigation when rebuilt.

By default, the page's title (the first heading in the file) is used for the Navigation Menu entry. You can overwrite a name of a Menu element by specifying it explicitly in the ``toctree`` block, for example: ``Reference </reference/index>``.


Configure settings
==================

Work through the settings in :file:`docs/conf.py`. Most parameters can be left with the default values as they can be changed later. :ref:`configure-your-project` contains further guidance.


Pre-commit hooks (optional)
===========================

Use `pre-commit <https://pre-commit.com/>`_ hooks with the starter pack
to automate checks like spelling and inclusive language.

The starter pack includes a ready-to-use :file:`.pre-commit-config.yaml` file
under :file:`docs/.sphinx/`:

.. literalinclude:: /.sphinx/.pre-commit-config.yaml
   :language: yaml

For a new project, copy this file to your project's root directory;
for an existing project using ``pre-commit``,
add these hooks to your configuration.

To apply the configuration, install the starter pack hooks, for instance::

  pre-commit install --config docs/.sphinx/.pre-commit-config.yaml


After that, you should see the checks running with every commit::

  git commit -m 'add spelling errors'

  Run make spelling.......................................................Failed
  Run make linkcheck......................................................Passed
  Run make woke...........................................................Passed
