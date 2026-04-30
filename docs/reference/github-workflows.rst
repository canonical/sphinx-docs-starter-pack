.. _github-workflows:

GitHub workflows
================

The primary documentation workflow checks spelling, links, and inclusive language in a documentation project; 
these are the same checks as described in :ref:`run-documentation-checks`.

The ``documentation-checks.yaml`` workflow covers these three checks and can be added to a new or existing workflow's jobs with:

.. code:: yaml

  jobs:
    [...]
    documentation-checks:
      uses: canonical/documentation-workflows/.github/workflows/documentation-checks.yaml@main
      with:
        working-directory: 'docs'


Workflows are also available for each individual check so that projects may run a subset of
those defined in ``documentation-checks.yaml``:

.. code:: yaml
  
  jobs:
    spell-check:
      uses: canonical/documentation-workflows/.github/workflows/spelling-check.yaml@main
      with:
        working-directory: "docs"
    inclusive-language-check:
      uses: canonical/documentation-workflows/.github/workflows/inclusive-language-check.yaml@main
      with:
        working-directory: "docs"    
    link-check:
      uses: canonical/documentation-workflows/.github/workflows/link-check.yaml@main
      with:
        working-directory: "docs"


Input
-----

The table below lists the inputs for the ``documentation-checks.yaml`` workflow. If your project consumes the 
Starter Pack in a non-traditional way, declare any of the following inputs to customize the workflow as needed:

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
     - The default Python version use. Example: ``'3.10'``
   * - ``fetch-depth``
     - The number of commits to fetch from your repository.
     - The full history is fetched.
   * - ``runs-on``
     - The host system for the workflow's runners.
     - The current Ubuntu LTS. Example: ``'["ubuntu-24.04"]'``
   * - ``makefile``
     - The Makefile that checks are invoked from.
     - ``'Makefile'``
   * - ``install-target``
     - The make target for installing required tools.
     - ``'install'``
   * - ``spelling-target``
     - The make target to run for the spelling check.
     - ``'spelling'``
   * - ``woke-target``
     - The make target to run for the inclusive language check.
     - ``'woke'``
   * - ``linkcheck-target``
     - The make target to run for the link check.
     - ``'linkcheck'``


Check for removed URLs
----------------------

.. versionadded:: 1.2.0

The Starter Pack includes a GitHub action to identify when pages have been removed. 
This includes moving pages to another path, or removing them completely.

This does not cover higher-level changes to URL paths, such as changes to the project name or URL slug pattern on RTD.

This check ensures that redirects are implemented when pages are moved, or
appropriate information is provided when anything is removed. It only runs
on pull request builds.

