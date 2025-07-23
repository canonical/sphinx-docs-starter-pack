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

The tools used by the automatic checks need ``npm`` and ``python3-venv``. 

Install ``npm`` using the appropriate method for your operating system using your preferred package manager, by following the `node version  manager installation process <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm>`_, or for Debian and Ubuntu Linux flavors with the ``sudo apt install npm`` command.

Similarly, if your system does not already have ``python3-venv``

To install the validation tools:

.. code-block:: bash

   make woke-install
   make pa11y-install
   make pymarkdownlnt-install  # if using Markdown

.. note::

   Both `woke` and `pa11y` are non-blocking checks in our current documentation workflow.

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
