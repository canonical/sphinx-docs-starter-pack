# Canonical's Sphinx Starter Pack

[![Test starter pack](https://github.com/canonical/sphinx-docs-starter-pack/actions/workflows/test-starter-pack.yml/badge.svg)](https://github.com/canonical/sphinx-docs-starter-pack/actions/workflows/test-starter-pack.yml)

A pre-configured repository to build documentation with [Sphinx] and publish it on [Read The Docs].

The Starter Pack contains build instructions, extensions with styling and configuration options, and automatic documentation checks.

## Using the Starter Pack

This repository contains example documentation that can be built out of the box.

To try it out, clone it locally and navigate to the `/docs` folder:

```shell
git clone git@github.com:canonical/sphinx-docs-starter-pack.git
cd docs
```

Then, run the command

```shell
make run
```

This will create a Python virtual environment, install necessary dependencies, build the documentation, and serve it in a local webserver.

You can access it in your browser at http://127.0.0.1:8000.

To learn more about how to install and configure the Starter Pack for your own project, see the [Set up a new project](https://canonical-starter-pack.readthedocs-hosted.com/stable/tutorial/set-up/) guide in the official documentation.

## Requirements and limitations

<!--Local build requirements - any linux OS? python preinstalled? I feel like this should be clarified in the section above though-->

The Starter Pack is designed for projects hosted on GitHub. This is necessary to run the automatic checks in .github/workflows, and to publish your documentation on Read The Docs.

If you have a project that is hosted on a different versioning platform, like Launchpad, [reach out to us](#reach-out).

## Community and support

The Canonical Sphinx Starter pack is an open-source project that warmly welcomes community involvement.

If you’re new to the community, make sure to read through the [Ubuntu Code of Conduct](https://ubuntu.com/community/code-of-conduct) first.

### Reach out

* Report an issue or make a suggestion via [GitHub](https://github.com/canonical/sphinx-docs-starter-pack/issues)
* Come chat with the Canonical Documentation team in our [public Matrix channel](https://matrix.to/#/#documentation:ubuntu.com)

### Contribute

The Starter Pack provides a shared foundation for Sphinx documentation projects, and contributions help improve the documentation of all its users.

* See [CONTRIBUTING.md](CONTRIBUTING.md) for more details about contributing to development or documentation
* Check [open issues](https://github.com/canonical/sphinx-docs-starter-pack/issues)

<!--
Tempted to remove this, since it's clearly explained in CONTRIBUTING.md

Please read and sign our [Contributor Licence Agreement (CLA)] before submitting any changes. The agreement grants Canonical permission to use your contributions. The author of a change remains the copyright owner of their code (no copyright assignment occurs).-->

<!--Links-->

[Sphinx]: https://www.sphinx-doc.org/
[Contributor Licence Agreement (CLA)]: https://ubuntu.com/legal/contributors
