Canonical's Sphinx Starter Pack
===============================

*A pre-configured repository to build and publish documentation with Sphinx.*

Description
-----------

The Documentation starter pack includes:

* a bundled Sphinx_ theme, configuration, and extensions
* support for both reStructuredText (reST) and Markdown
* build checks for links, spelling, and inclusive language
* customisation support layered above a core configuration

See the full documentation: https://canonical-starter-pack.readthedocs-hosted.com/use-canonical-sphinx-extension/

Structure
---------

This section outlines the structure of this repository, and some key files.

init.sh
*******

This script is an entrypoint intended to simplify adoption of this starter pack.
Simply download the script, and run it locally.

sp-files
********

This directory contains the files required for the functionality of the starter pack.
If you do not wish to use the ``init.sh`` script, these are the files you should be using.

sp-docs
*******

This directory contains files in use for the documentation of this project.

sp-tests
********

This directory contains files used to test the functionality of the starter pack project.

.. LINKS

.. _`Sphinx`: https://www.sphinx-doc.org/