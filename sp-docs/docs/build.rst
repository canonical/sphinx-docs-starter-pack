.. _build:

Build and preview
=================

The starter pack provides make commands to build and view the documentation.
All these commands will automatically set up the Python environment if it isn't set up yet.

.. _build-docs:

Build the documentation
-----------------------

To build the documentation, run the following command::

  make html

This command installs the required tools and renders the output to the :file:`_build/` directory in your documentation directory.

.. important::
   When you run :command:`make html` again, it updates the documentation for changed files only.

   This speeds up the build, but it can cause you to miss warnings or errors that were displayed before.
   To force a clean build, see :ref:`build-clean`.

Make sure that the documentation builds without any warnings (warnings are treated as errors).

.. _build-clean:

Run a clean build
-----------------

To delete all existing output files and build all files again, run the following command::

  make clean-doc html

To delete both the existing output files and the Python environment and build the full documentation again, run the following command::

  make clean html

View the documentation
----------------------

To view the documentation output, run the following command::

  make serve

This command builds the documentation and serves it on :literalref:`http://127.0.0.1:8000/`.


Live view
---------

Instead of building the documentation for each change and then serving it, you can run a live preview of the documentation::

  make run

This command builds the documentation and serves it on :literalref:`http://127.0.0.1:8000/`.
When you change a documentation file and save it, the documentation will be automatically rebuilt and refreshed in the browser.

.. important::
   The :command:`run` target is very convenient while working on documentation updates.

   However, it is quite error-prone because it displays warnings or errors only when they occur.
   If you save other files later, you might miss these messages.

   Therefore, you should always :ref:`build-clean` before finalising your changes.
