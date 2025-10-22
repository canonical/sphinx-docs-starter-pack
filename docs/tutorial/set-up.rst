.. _set-up:

===================================
Set up the documentation repository
===================================

This page contains a short guide on how to set up and use the starter pack.

.. _initial-setup:

Copy the starter pack
=====================

If you're starting a new project, clone the `starter pack repository <https://github.com/canonical/sphinx-docs-starter-pack>`_ and begin your project from there.

If you're adding documentation to an existing software project, download the following files from the repository and copy them into your existing repository:

* the entire :file:`docs` directory
* :file:`.readthedocs.yaml` (configuration for the building on Read the Docs)
* :file:`.wokeignore` (configuration for the Woke tool)
* the entire :file:`.github/workflows` directory


.. _remove-unneeded-files:

Remove the unneeded files
=========================

Next, review the files inherited from the starter pack and remove those that could interfere with your project.

Remove the files that can't be reused:

- :file:`.github/CODEOWNERS`
- :file:`.github/workflows/test-starter-pack.yml`

Review and remove the GitHub workflows in ``.github/workflows/`` that your project might not need:

- :file:`sphinx-python-dependency-build-checks.yml` verifies Sphinx dependencies
- :file:`markdown-style-checks.yml` calls the built-in Markdown linter


Build and run the local server
==============================

Building the documentation requires ``make``, ``python3``, ``python3-venv``, ``python3-pip``.

In :file:`docs`, run::

    make run

This creates and activates a virtual environment in :file:`docs/.sphinx/venv`, builds the documentation and serves it at :literalref:`http://127.0.0.1:8000/`.

The server watches the source files, including :file:`docs/conf.py`, and rebuilds automatically on changes.

The landing page is :file:`docs/index.rst`. Other pages are under one of the sub-directories under :file:`docs/`.


Configure settings
==================

Work through the settings in :file:`docs/conf.py`. Most parameters can be left with the default values as they can be changed later. :ref:`customise` contains further guidance.


Pre-commit hooks (optional)
===========================

Use `pre-commit <https://pre-commit.com/>`_ hooks with the starter pack
to automate checks like spelling and inclusive language.

The starter pack includes a ready-to-use :file:`.pre-commit-config.yaml` file
under :file:`docs/.sphinx/`:

.. literalinclude:: ../.sphinx/.pre-commit-config.yaml
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
