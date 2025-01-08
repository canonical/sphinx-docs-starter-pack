.. _quickstart:

================
Quickstart guide
================

This page contains a short guide on how to set up and use the starter pack. For more information, see the respective sections of the starter pack documentation: 
:ref:`setup`, :ref:`update`, :ref:`automatic-checks`.

Initial setup
=============

Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a temporary local folder.

Copy the following folders and files preserving their paths from the starter pack to the repository you want your documentation to be:

   - :file:`docs`
   - :file:`.readthedocs.yaml`
   - :file:`.wokeignore`
   - :file:`.github/workflows/*-checks.yml`


Build and run the local server
==============================

Prerequisites (which you probably have installed already) are:

* ``make`` 
* ``python3``
* ``python3-venv``
* ``python3-pip`` 

In :file:`docs` run::

    make run

This: creates and activates a virtual environment in :file:`docs/.sphinx/venv`, builds the documentation and serves it at :literalref:`http://127.0.0.1:8000/`.

The server watches the source files, including :file:`conf.py`, and rebuilds automatically on changes.

Configure
=========

Work through the settings in :file:`conf.py`. Most parameters can be left as they are or simply ignored. They can all be changed later.

Update content
==============

The landing page is :file:`docs/index.rst`. Other pages are under :file:`docs/content`.
