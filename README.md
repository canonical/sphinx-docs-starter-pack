# Sphinx Stack

[![Sphinx Stack test](https://github.com/canonical/sphinx-stack/actions/workflows/test-sphinx-stack.yml/badge.svg)](https://github.com/canonical/sphinx-stack/actions/workflows/test-sphinx-stack.yml)

A standard set of tools for building and publishing Sphinx documentation.

The Sphinx Stack contains a set of CLI commands and a default set of extensions,
configuration options, and tests.

## Basic usage

To try out the Sphinx Stack, clone it locally and navigate to the `/docs` directory:

```shell
git clone git@github.com:canonical/sphinx-stack.git
cd docs
```

Then, run the command

```shell
make run
```

This will create a Python virtual environment, install necessary dependencies, build the
documentation, and serve it to http://127.0.0.1:8000.

To learn more about how to install and configure the Sphinx Stack for your own project,
see the [Set up a new
project](https://canonical-sphinx-stack.readthedocs-hosted.com/latest/set-up-a-new-project/)
guide in the official documentation.

## Requirements and limitations

The Sphinx Stack is designed for projects hosted on GitHub. This is necessary to run the
automatic checks in .github/workflows, and to publish your documentation on Read the
Docs.

If you have a project that is hosted on a different versioning platform, like Launchpad,
[reach out to us](#reach-out).

## Community and support

The Sphinx Stack is an open-source project that warmly welcomes community involvement.

If you’re new to the community, make sure to read through the [Ubuntu Code of
Conduct](https://ubuntu.com/community/code-of-conduct) first.

### Reach out

* Report an issue or make a suggestion via
  [GitHub](https://github.com/canonical/sphinx-stack/issues)
* Come chat with the Canonical Documentation team in our [public Matrix
  channel](https://matrix.to/#/#documentation:ubuntu.com)

### Contribute

The Sphinx Stack provides a shared foundation for Sphinx documentation projects, and
contributions help improve the documentation of all its users.

* See [CONTRIBUTING.md](CONTRIBUTING.md) for more details on contributing to
  development or documentation.
* Check [open issues](https://github.com/canonical/sphinx-stack/issues)
