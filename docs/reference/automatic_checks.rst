.. _automatic-checks:

Automatic checks
================

The starter pack comes with several automatic checks that you can (and should!) run on your documentation before committing and pushing changes.

The following checks are available:

.. toctree::
   :maxdepth: 1
   :glob:

   /reference/automatic_checks_*

Install prerequisite software
-----------------------------

Some of the tools used by the automatic checks require ``npm``. Install ``npm`` using the appropriate method for your operating system through one of the following methods: 

* Your preferred package manager 
* By following the `node version manager installation process <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm>`_
* For Debian and Ubuntu Linux distributions, the ``sudo apt install npm`` command

To install the validation tools:

.. code-block:: bash

   make pa11y-install
   make pymarkdownlnt-install  # if using Markdown

.. note::

   `pa11y` is a non-blocking check in our current documentation workflow.

Default GitHub actions
----------------------

The starter pack uses default workflows from the
`documentation-workflows <https://github.com/canonical/documentation-workflows/>`_
repository.

The current defaults force usage of Canonical hosted runners, which some projects
may not be able to use. You may select your own runners with an override, see line 7 below:

.. class:: vale-ignore
.. code-block::
   :emphasize-lines: 7
   :linenos:

   jobs:
   documentation-checks:
      uses: canonical/documentation-workflows/.github/workflows/documentation-checks.yaml@main
      with:
         working-directory: "docs"
         fetch-depth: 0
         runs-on: "ubuntu-22.04"

Workflow triggers
-----------------

For efficiency, the documentation check workflows are configured to run **only** when
changes are made to files in the ``docs/`` directory. If your project is structured
differently, or if you want to run the checks on other directories, modify the trigger
paths in the workflow files:

.. class:: vale-ignore
.. code-block:: yaml
   :emphasize-lines: 4

   on:
     pull_request:
       paths:
         - 'docs/**'   # Only run on changes to the docs directory
