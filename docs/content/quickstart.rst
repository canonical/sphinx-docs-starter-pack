.. _quickstart:

Quickstart guide
-----------------

This guide is about the starter pack setup and usage.

Initial setup
*************

The following steps will guide you through setting up your documentation:

#. Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a temporary local folder.
#. Copy the following folders and files from the starer pack to the same paths in the repo you want your documentation to be:

   - :file:`.github/workflows/*-checks.yml`
   - :file:`docs`
   - :file:`.readthedocs.yaml`
   - :file:`.wokeignore`
#. Configure your new documentation set by adjusting the copied :file:`docs/conf.py` config file.

For more information on the initial setup, see the :ref:`setup` section.

Build
*****

Starter pack needs the following packages installed:

* `make` 
* `python3`
* `python3-venv`
* `python3-pip` 

To build documentation, use the following command:

.. code-block::

   make run

This command creates a virtual environment, installs the Python dependencies, builds the documentation, and serves it on the :literalref:`http://127.0.0.1:8000/` address.

For more information on different commands for building and viewing the documentation, see the :ref:`build` page.

Update content
**************

The landing page is stored in the :file:`docs/index.rst` file 
while the rest of the pages are stored in the :file:`docs/content` folder.

For more information on how to edit existing files, see the :ref:`edit` page.

To check the rendered documentation: 

1. Build the documentation as instructed in the Build section above.
2. Keep the `make run` command running in the terminal to rebuild the documentation automatically whenever a file in the `docs/content` is saved. 
3. Open the :literalref:`http://127.0.0.1:8000/` address in a web browser to see the locally built and hosted documentation as HTML.

For more information about the |RST| and Markdown/MyST syntax and other useful resources, see the :ref:`guidance` page.
