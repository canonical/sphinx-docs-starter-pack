.. meta::
    :description: Learn about the function, structure, and design of the build process in Canonical's Starter Pack.

:relatedlinks: [GNU&#32;Make](https://www.gnu.org/software/make/)


.. _explanation-build:

Build
=====

Canonical's Starter Pack uses Make as its build system. Make was chosen because it's
well-tested and available on all platforms. The majority of the build configuration is
defined in ``docs/Makefile``.

Make is also the user interface for operating a project's docs. Authors and developers
call all docs actions with ``make <action>``.

The docs build depends on environment variables like ``BUILDDIR`` to locate critical
files. They are conditional variables, so other systems can invoke the build at
different locations without changing the docs ``Makefile``.

Being primarily a Python project, all dependencies are stored in a virtual environment,
``docs/.sphinx/venv``. The environment is ephemeral and subject to frequent change.
Installing the starter pack initializes it, while cleaning and upgrading tears it
down and rebuilds it.


.. _explanation-parent-project-build:

Parent projects and the build
-----------------------------

The starter pack is arranged as a standalone project. When it's used in a larger
project, the docs are a subsystem among other components.

If the parent project uses a build system, Make or otherwise, the doc build exists in
parallel with the parent build. When embedded, the virtual environment and build recipe
files would be arranged along these lines:

.. code-block::

    Project
    │
    ├── ...
    ├── docs
    │   ├── ...
    │   ├── .sphinx/venv
    │   └── Makefile
    ├── src
    │   └── ...
    ├── <parent build recipes>
    └── <parent virtual environment>

With embedded docs, the parent build doesn't mesh with the docs build, which can cause
difficulty:

- Contributors typically call the build commands from the root of the project. Some will
  find it inconvenient to run the docs commands by switching to the ``docs`` directory
  or manually calling the docs Makefile with ``make -C docs <action>``.
- Storing multiple virtual environments bloats the host system. It's reasonable for
  project maintainers to prefer a shared build environment.
- The starter pack's upgrade process can make changes to many files in the ``docs``
  directory. Upgrading is potentially much simpler if the parent project modifies only
  a minimum of files in the directory.
- With quality assurance and continuous integration, it's simpler if the project can use
  the same interface to run local and remote checks. More specifically, the parent build
  system and CI need a way to call the starter pack's ``links``, ``spelling``, and
  ``vale`` checks.

One possible resolution is for the parent build to manually recreate the docs build,
tightly coupling the parent build to the existing docs configuration. But this poses
another challenge, because the docs ``Makefile`` might change during a starter pack
update, requiring a rewrite of the parent build recipes.

The solution to these complications is to create a bridge between the two builds, from
the parent build to the docs ``Makefile``.
:ref:`how-to-bridge-project-builds` is a guide for how to do this.
