.. _ci-workflows:

CI Workflows
============

The primary documentation workflow checks spelling, links, and inclusive language in a documentation project. `documentation-checks.yaml` workflow covers these three checks and can be added to a new or existing workflow's jobs with:

.. code:: yaml

  jobs:
    [...]
    documentation-checks:
      uses: canonical/documentation-workflows/.github/workflows/documentation-checks.yaml@main
      with:
        working-directory: 'docs'


Workflows are also available for each individual check so that projects may run a subset of
those defined in `documentation-checks.yaml`:

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

The table below lists the inputs for the various CI workflows. If your project consumes the 
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
     - ``'3.10'``
   * - ``fetch-depth``
     - The number of commits to fetch from your repository.
     - The full history is fetched.
   * - ``runs-on``
     - The host system for the workflow's runners.
     - ``'["ubuntu-24.04"]'``
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

The starter pack includes a GitHub action to
identify when page URLs have been removed. This includes moving pages to another
path, or removing them completely.

This does not cover higher-level changes to URL paths, such as changing the RTD 
project name, or language and versioning structure provided by RTD.

This check is available to ensure that redirects are implemented when pages are
moved, or appropriate information can be provided when anything is removed.