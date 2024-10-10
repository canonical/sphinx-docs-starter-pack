Canonical's Sphinx Starter Pack
===============================

*A pre-configured repository to build and publish documentation with Sphinx.*

Description
-----------

The Documentation starter pack includes:

* A bundled Sphinx_ theme, configuration, and extensions
* Support for both reStructuredText (reST) and MyST Markdown
* Build checks for links, spelling, and inclusive language
* Customisation support layered over a core configuration

See the full documentation: https://canonical-starter-pack.readthedocs-hosted.com/

Structure
---------

This section outlines the structure of this repository, and some key files.

init.sh
*******

This script is an entrypoint intended to simplify adoption of this starter pack.
Download and run this file it to install the starter pack in an arbitrary directory of the repo.

sp-files
********

This directory contains the files required for the functionality of the starter pack.
If you don't want to run ``init.sh`` for some reason, use these files.

sp-docs
*******

This directory contains the documentation for the starter pack itself.
To view it in your browser, change to this directory and type `make run`.

sp-tests
********

This directory contains files used to test the functionality of the starter pack project.

.. LINKS

.. _`Sphinx`: https://www.sphinx-doc.org/
