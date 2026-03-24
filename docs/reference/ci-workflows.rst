.. _ci-workflows:

CI Workflows
============


Workflows are available for each individual check so that projects may run a subset of
those defined in `documentation-checks.yaml`. The following jobs are equivalent to the
`documentation-checks` job from the previous example:

```yaml
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
```

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
