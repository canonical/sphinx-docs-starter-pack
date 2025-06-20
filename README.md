# Canonical's Sphinx Starter Pack

*A pre-configured repository to build and publish documentation with Sphinx.*

## Description

The Documentation starter pack includes:

* A bundled [Sphinx] theme, configuration, and extensions
* Support for both reStructuredText (reST) and MyST Markdown
* Build checks for links, spelling, and inclusive language
* Customisation support layered over a core configuration

See the full documentation: https://canonical-starter-pack.readthedocs-hosted.com/

## Structure

This section outlines the structure of this repository, and some key files.

### `docs/`

This directory contains the documentation for the starter pack itself.

To view it in your browser, navigate to this directory and type `make run`.

### `.github/workflows/`

This directory contains files used for documentation build checks via GitHub's CI.

The file `test-starter-pack.yml` tests the functionality of the starter pack project.

## Contributing

We welcome contributions to this project! If you have suggestions, bug fixes, or improvements, please open an issue or submit a pull request.

Please read and sign our [Contributor Licence Agreement (CLA)] before submitting any changes. The agreement grants Canonical permission to use your contributions. The author of a change remains the copyright owner of their code (no copyright assignment occurs).

<!--Links-->

[Sphinx]: https://www.sphinx-doc.org/
[Contributor Licence Agreement (CLA)]: https://ubuntu.com/legal/contributors
