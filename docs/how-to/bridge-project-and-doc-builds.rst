.. meta::
    :description: How to bridge the build of Canonical's Starter Pack and a parent project's build.

:relatedlinks: [pip&#32;and&#32;dependency&#32;groups](https://pip.pypa.io/en/stable/user_guide/#dependency-groups), [uv&#32;and&#32;dependency&#32;groups](https://docs.astral.sh/uv/concepts/projects/dependencies/#dependency-groups), [Poetry&#32;and&#32;dependency&#32;groups](https://python-poetry.org/docs/managing-dependencies#dependency-groups)


.. _how-to-bridge-project-builds:

Bridge project and docs builds
==============================

.. If more parent projects and build systems are tested, make the introduction general 
   and add tabs to each of the steps

The starter pack can be used as a standalone docs repository, or embedded inside a
parent project. This guide demonstrates how to bridge the docs build with a Python
project's main build. Once bridged, project contributors can install, build, and check
the docs from the root of the project with the main build system.

:ref:`explanation-parent-project-build` describes the full benefits of bridging the
build in a larger project.


.. _how-to-bridge-project-builds-project-requirements-layout:

Plan and requirements
---------------------

The bridge is built by making up to three changes to the build.

The bridge **shims the docs build targets in the main build**. Any build system is
capable of adding targets that call other systems. When shimmed, the docs targets like
``html`` and ``clean`` pass through to ``docs/Makefile``, with arguments.

The bridge also **merges the virtual environments**, removing the need for a separate
docs environment. This change is optional but recommended. To combine environments, your
project must provide **Python 3.11** or higher to the starter pack. Any Python
dependency manager will do, and this guide illustrates with three:

- pip 25.1 and higher
- uv 0.4.27 and higher
- Poetry 1.2.0a2 and higher

After adding the bridge, it's also possible to **adjust the documentation workflows** to
use your project's main build. The workflows were designed with Make, so they only work
if you use it for your build system.


Example project layout
----------------------

This guide illustrates the bridge through an example project. In the example project,
the file tree contains:

.. code-block::

    Project
    │
    ├── ...
    ├── docs
    │   └── Makefile
    ├── .venv
    ├── Makefile
    └── pyproject.toml

The example project's root ``Makefile`` has two conventional targets that need
adjustment:

- ``setup`` for building the virtual environment and syncing dependencies
- ``clean`` for cleaning up the virtual environment and temporary files


.. _how-to-bridge-project-builds-set-docs-env-vars:

Set the build paths
-------------------

Where your main build sets environment variables, redeclare the docs environment
variables that specify the build paths:

- ``BUILDDIR`` is the destination for the docs. If you have special distribution needs
  you can override this, but for most builds this can be left as-is.
- ``VENVDIR`` is the virtual environment of the docs. If you're merging the virtual
  environments, set this as a relative path from the docs directory to your project's
  virtual environment.
- ``VALEDIR`` is the path to the Vale binary. The full path depends on the
  location of your virtual environment, so it's best to copy this as-is.

In the example project, this looks like:

.. code-block:: make
    :caption: Makefile

    # Env vars for the docs build
    export BUILDDIR ?= _build
    export VENVDIR ?= ../.venv
    export VALEDIR ?= $(VENVDIR)/lib/python*/site-packages/vale


.. _how-to-bridge-project-builds-integrate-docs-setup:

Integrate the docs setup
------------------------

The next step is to incorporate the docs installation target, and optionally the
dependencies, into the main build.


Separate virtual environments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't plan to merge the virtual environments, override the installation target by
calling all three doc installation targets in a row.

In the example project, this is written as:

.. code-block:: make
    :caption: Makefile

    # Override the 
    .PHONY: docs-install
    docs-install:
        $(MAKE) -C docs install --no-print-directory
        $(MAKE) -C docs vale-install --no-print-directory
        $(MAKE) -C docs pymarkdownlnt-install --no-print-directory


Merged virtual environments
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To merge virtual environments, you make the main ``setup`` target handle both
development and docs packages, and enumerate all docs packages in ``pyproject.toml``.

By adding dependency groups, the docs packages, plus any custom Sphinx extensions, can
be managed by the main build and stored in one virtual environment. The result will be
three dependency groups in ``pyproject.toml``:

- ``dev`` for development builds
- ``docs`` for extra docs packages that your project needs
- ``docs-starter-pack`` for the core docs packages set by the starter pack

First, add these dependency groups, and make the docs dependencies include the
starter pack packages:

.. code-block:: toml
    :caption: pyproject.toml

    [dependency-groups]
    dev = [
        # Packages for main development and testing
    ]
    docs = [
        # Packages for extra docs features
        {include-group = "docs-starter-pack"},
    ]
    docs-starter-pack = [
        # Core docs packages
    ]

If you don't already have a ``dev`` dependency group, review the packages listed in the
file's ``dependencies`` key, then move any non-runtime dependencies to the ``dev``
dependency group.

If your project needs extra docs features, like the Mermaid or LaTeX Sphinx extensions,
add their packages to the ``docs`` group.

Copy the contents of ``docs/requirements.txt`` into the ``docs-starter-pack`` group.

In the main build, override the docs installation target and make the project's
``setup`` target depend on it. In the example project, it is written like this:

.. tabs::

  .. tab:: pip

    .. code-block:: make
        :caption: Makefile
        :emphasize-lines: 2-3, 7-12

        .PHONY: setup
        setup: docs-install
            pip install --group dev

        # ...

        # Override for `install` target in docs project
        .PHONY: docs-install
        docs-install:
            pip install --group docs
            $(MAKE) -C docs vale-install --no-print-directory
            $(MAKE) -C docs pymarkdownlnt-install --no-print-directory

  .. tab:: uv

    .. code-block:: make
        :caption: Makefile
        :emphasize-lines: 2-3, 7-12

        .PHONY: setup
        setup: docs-install
            uv sync --group dev

        # ...

        # Override for `install` target in docs project
        .PHONY: docs-install
        docs-install:
            uv sync --no-dev --group docs
            $(MAKE) -C docs vale-install --no-print-directory
            $(MAKE) -C docs pymarkdownlnt-install --no-print-directory

  .. tab:: Poetry

    .. code-block:: make
        :caption: Makefile
        :emphasize-lines: 2-3, 7-12

        .PHONY: setup
        setup: docs-install
            poetry install --only dev

        # ...

        # Override for `install` target in docs project
        .PHONY: docs-install
        docs-install:
            poetry install --only docs
            $(MAKE) -C docs vale-install --no-print-directory
            $(MAKE) -C docs pymarkdownlnt-install --no-print-directory

If your docs aren't written in Markdown, remove the command that runs the
``pymarkdownlnt-install`` target.


.. _how-to-bridge-project-builds-shim-remaining-targets:

Shim the remaining targets
--------------------------

The docs build has many targets, but only a handful of them overlap or collide with most
project builds, so we only need to override two more. The rest can pass straight through
to the docs build.

In the example project, the main build calls the targets like this:

.. code-block:: make
    :caption: Makefile

    # Override for `clean` target in docs project. We don't want to touch `.venv`,
    # so we pass a null dir instead.
    .PHONY: docs-clean
    docs-clean:
    	VENVDIR=null $(MAKE) -C docs clean --no-print-directory

    # Override for `help` target
    .PHONY: docs-help
    docs-help:
    	@echo "Commands in the documentation subproject:"
    	$(MAKE) -C docs help --no-print-directory
    	@echo "Run these commands with 'make docs-<command>' in the project root."

    # Shim for the rest of the targets in docs Makefile
    .PHONY: docs-%
    docs-%: docs-install
    	$(MAKE) -C docs $(@:docs-%=%) --no-print-directory


.. _how-to-bridge-project-builds-adjust-rtd-build:

Adjust the Read the Docs build
------------------------------

With the Makefile in a different location than usual, and its being a separate process,
it's simplest to override the Read The Docs build in ``.readthedocs.yaml`` to call the
same build targets that developers use locally.

If you use an uncommon system, you might need to install it during the workflow's
``create_environment`` job.

If you merged the virtual environments, make sure to set ``VENVDIR=${READTHEDOCS_VIRTUALENV_PATH}`` in all commands.

Here's what it looks like in the example project:

.. code-block:: yaml
    :caption: .readthedocs.yaml
    :emphasize-lines: 8-14

    build:
      os: ubuntu-24.04
      tools:
        python: "3.12"
      jobs:
        post_checkout:
          - git fetch --tags --unshallow # Also fetch tags
        create_environment:
          - python3 -m venv "${READTHEDOCS_VIRTUALENV_PATH}"
        install:
          - make docs-install VENVDIR="${READTHEDOCS_VIRTUALENV_PATH}"
        build:
        html:
          - make docs VENVDIR="${READTHEDOCS_VIRTUALENV_PATH}" BUILDDIR="$READTHEDOCS_OUTPUT/html/"


.. _how-to-bridge-project-builds-adjust-doc-workflows:

Adjust the doc workflows
------------------------

If your project uses the starter pack's docs workflows *and* Make, adjust the workflows
to use the bridged targets.

For the main checks, override the target names and paths through the `workflow inputs
<https://github.com/canonical/documentation-workflows/blob/main/.github/workflows/documentation-checks.yaml#L5-L54>`_:

.. code-block:: yaml
    :caption: .github/workflows/automatic-doc-checks.yml
    :emphasize-lines: 5, 7-11

    jobs:
      documentation-checks:
        uses: canonical/documentation-workflows/.github/workflows/documentation-checks.yaml@main
        with:
          working-directory: "."
          fetch-depth: 0
          install-target: docs-install
          spelling-target: docs-spelling
          woke-target: docs-woke
          linkcheck-target: docs-linkcheck
          pa11y-target: docs-pa11y

If your docs are written in Markdown, override the path and command inputs in the
Markdown linter workflow:

.. code-block:: yaml
    :caption: .github/workflows/markdown-style-checks.yml
    :emphasize-lines: 2-6

    - name: Create venv
      working-directory: "."
      run: make docs-install
    - name: Lint markdown
      working-directory: "."
      run: make docs-lint-md
