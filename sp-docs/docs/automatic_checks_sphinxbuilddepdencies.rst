.. _automatic-checks-sphinxbuilddependencies:

Sphinx environment build dependencies
=====================================

The `Sphinx environment build dependencies check`_ is a GitHub Actions workflow
that ensures all the build dependencies required for a Sphinx virtual
environment are correctly documented and can be successfully built from source.

This is crucial for projects that integrate documentation generation into their
build artefacts, especially when built on various target architectures where
pre-built Python packages may not be available.

Run the Python build dependencies check
---------------------------------------

To use this GitHub Action workflow, copy the
`sphinx-python-dependency-build-checks.yml`_ file into the `.github/workflows`
directory of your documentation repository, and commit the changes.

The workflow will be triggered for any ``push`` or ``pull_request`` events to
your repository, or be triggered manually.

.. _Sphinx environment build dependencies check: https://github.com/canonical/sphinx-docs-starter-pack/blob/main/sp-files/.github/workflows/sphinx-python-dependency-build-checks.yml
.. _sphinx-python-dependency-build-checks.yml: https://github.com/canonical/sphinx-docs-starter-pack/blob/main/sp-files/.github/workflows/sphinx-python-dependency-build-checks.yml
