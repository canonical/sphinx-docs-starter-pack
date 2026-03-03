.. _build-and-preview:

Build and preview
=================

The starter pack provides a :file:`Makefile` that defines :command:`make` commands to build and view the documentation.

This guide describes how to set up your environment and use these commands to build and preview the documentation locally.

For more advanced information, including how to embed your docs build with your project build, see:

- :ref:`build-system`
- :ref:`How to customise your build <customise-your-build>`

Install prerequisite software
-----------------------------

The documentation framework that the starter pack uses bundles most prerequisites in a Python virtual environment, so you don't need to worry about installing them.
There are only a few packages that you need to install on your host system.

Before you start, make sure that you have ``make``, ``python3``, ``python3-venv``, and ``python3-pip`` on your system::

   sudo apt update
   sudo apt install make python3 python3-venv python3-pip

Python environment
------------------

The Python prerequisites from the :file:`docs/requirements.txt` file are automatically installed when you build the documentation.

If you want to install them manually, you can run the following command from within your documentation folder::

   make install

This command creates a virtual environment (:file:`.sphinx/venv/`) and installs dependency software within it.

If you want to remove the installed Python packages (for example, to enforce a re-installation), run the following command from within your documentation folder::

  make clean

.. note::
   - By default, the starter pack uses the latest compatible version of all tools and does not pin its requirements.
     This might change temporarily if there is an incompatibility with a new tool version.
     There is therefore no need to use a tool like Renovate to automatically update the requirements.

   - If you encounter the error ``locale.Error: unsupported locale setting`` when activating the Python virtual environment, include the environment variable in the command and try again: ``LC_ALL=en_US.UTF-8 make run``


.. important::
   Run these commands from within your documentation folder.

.. _build-docs:

Build the documentation
-----------------------

To build the documentation, run the following command::

  make html

This command installs the required tools and renders the output to the :file:`_build/` folder in your documentation folder.

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

Build a PDF
-----------

Build a PDF locally with the following command:

.. code-block:: none

    make pdf

PDF generation requires specific software packages. If these files are not found, a prompt will be presented and the generation will stop.

Required software packages include:

* dvipng
* fonts-freefont-otf
* latexmk
* plantuml
* tex-gyre
* texlive-font-utils
* texlive-fonts-recommended
* texlive-lang-cjk
* texlive-latex-extra
* texlive-latex-recommended
* texlive-xetex
* xindy

On Linux, required packages can be installed with:

.. code-block:: none

    make pdf-prep-force
    
.. note::

    When generating a PDF, the index page is considered a 'foreword' and will not be labelled with a chapter.

.. important::

    When generating a PDF, it is important to not use additional headings before a ``toctree``. Documents referenced by the
    ``toctree`` will be nested under any provided headings.

    A ``rubric`` directive can be combined with the ``h2`` class to provide a heading-styled rubric in the HTML output. See the default ``index.rst`` for an example.
    Rubric-based headings aren't included as entries in the table of contents or the navigation sidebar.
