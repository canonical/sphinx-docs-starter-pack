.. _quickstart:

================
Quickstart guide
================

This page contains a short guide on how to set up and use the starter pack. 


Initial setup
=============

Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a local folder.

Assuming that you have an existing repository that you want to build documentation in, you'll need to copy some files to it. Copy:

* the entire :file:`docs` directory
* :file:`.readthedocs.yaml` (configuration for the building on ReadTheDocs)
* :file:`.wokeignore` (configuration for the Woke tool)
* the entire :file:`.github/workflows` directory 

You **must** delete :file:`.github/workflows/test-starter-pack.yml`.

Build and run the local server
==============================

Building the documentation requires ``make``, ``python3``, ``python3-venv``, ``python3-pip``.

In :file:`docs`, run::

    make run

This creates and activates a virtual environment in :file:`docs/.sphinx/venv`, builds the documentation and serves it at :literalref:`http://127.0.0.1:8000/`.

The server watches the source files, including :file:`docs/conf.py`, and rebuilds automatically on changes.

Configure
=========

Work through the settings in :file:`docs/conf.py`. Most parameters can be left with the default values as they can be changed later.

Update content
==============

The landing page is :file:`docs/index.rst`. Other pages are under :file:`docs/content`.
