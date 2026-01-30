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

The :literalref:`documentation-checks.yaml
<https://github.com/canonical/documentation-workflows/blob/main/.github/workflows/documentation-checks.yaml>`
workflow comes from the `documentation-checks
<https://github.com/canonical/documentation-workflows>`_ repository and supports the
following inputs.

.. list-table::
    :header-rows: 1

    * - Input
      - Description
      - Default
    * - ``working-directory``
      - The root of the documentation project. This input is required.
      - None
    * - ``python-version``
      - The Python interpreter to use for the workflow's jobs.
      - ``'3.10'``
    * - ``makefile``
      - The Makefile that checks are invoked from. Defaults to ``'Makefile.sp'`` if it exists, or ``'Makefile'`` if it doesn't.
      - ``'Makefile.sp'`` or ``'Makefile'``
    * - ``install-target``
      - The make target for installing required tools.
      - ``'install'``
    * - ``spelling-target``
      - The make target to run for the spelling check.
      - ``'spelling'``
    * - ``woke-target``
      - The make target to run for the inclusive language check
      - ``'woke'``
    * - ``linkcheck-target``
      - The make target to run for the link check.
      - ``'linkcheck'``
    * - ``'fetch-depth'``
      - The desired fetch depth.
      - ``'0'``
    * - ``-target``
      - The GitHub runners' host system.
      - ``'["ubuntu-24.04"]'``
    * - ``pa11y-target``
      - The make target to run for the accessibility check.
      - ``'pa11y'``

The current defaults force usage of Canonical-hosted runners, which some projects
may not be able to use. You may select your own runners by providing a ``runs-on``
value, as shown by line 7 in the following example:

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

.. code-block:: yaml
   :emphasize-lines: 4

   on:
     pull_request:
       paths:
         - 'docs/**'   # Only run on changes to the docs directory
