.. _work:

Work with your documentation
----------------------------

This section is for documentation contributors. It assumes that the current
repository has been initialised with the starter pack as described in section
:ref:`enable`.

There are make targets defined in the :file:`Makefile` that provide different functionality. To
get started, we will:

* install prerequisite software
* view the documentation

Install prerequisite software
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you start, make sure you have ``make``, ``python3``, ``python3-venv``,
and ``python3-pip`` on your system:

.. code-block:: none

   sudo apt update
   sudo apt install make python3 python3-venv python3-pip

Some `validation tools <#local-checks>`_ won't be available by default. To
install them, you need ``snap`` and ``npm``:

.. code-block:: none

   sudo apt install npm snapd

To install the core prerequisites:

.. code-block:: none

   make install

This will create the required software list (``.sphinx/requirements.txt``),
which is used to create a virtual environment (``.sphinx/venv``) and install
dependency software within it.

To install the validation tools:

.. code-block:: none

   make woke-install
   make pa11y-install

You can add further Python modules to the required software list
(``.sphinx/requirements.txt``) in the ``custom_required_modules`` variable
in the ``custom_conf.py`` file.

**Note**:
By default, the starter pack uses the latest compatible version of all tools and does not pin its requirements.
This might change temporarily if there is an incompatibility with a new tool version.
There is therefore no need in using a tool like Renovate to automatically update the requirements.

View the documentation
~~~~~~~~~~~~~~~~~~~~~~

To view the documentation:

.. code-block:: none

   make run

This will perform several actions:

* activate the virtual environment
* build the documentation
* serve the documentation on **127.0.0.1:8000**
* rebuild the documentation each time a file is saved
* send a reload page signal to the browser when the documentation is rebuilt

The ``run`` target is therefore very convenient when preparing to submit a
change to the documentation.

.. note::

   If you encounter the error ``locale.Error: unsupported locale setting`` when activating the Python virtual environment, include the environment variable in the command and try again: ``LC_ALL=en_US.UTF-8 make run``

.. _local-checks:

Local checks
~~~~~~~~~~~~

Before committing and pushing changes, it's a good practice to run various checks locally to catch issues early in the development process.

Local build
^^^^^^^^^^^

Run a clean build of the docs to surface any build errors that would occur in RTD:

.. code-block:: none

   make clean-doc
   make html

Spelling check
^^^^^^^^^^^^^^

Ensure there are no spelling errors in the documentation:

.. code-block:: shell

   make spelling

Inclusive language check
^^^^^^^^^^^^^^^^^^^^^^^^

Ensure the documentation uses inclusive language:

.. code-block:: shell

   make woke

Accessibility check
^^^^^^^^^^^^^^^^^^^

Look for accessibility issues in rendered documentation:

.. code-block:: shell

   make pa11y

Link check
^^^^^^^^^^

Validate links within the documentation:

.. code-block:: shell

   make linkcheck

Style guide linting
^^^^^^^^^^^^^^^^^^^

Check documentation against the `Vale documentation linter configured with the current style guide <https://github.com/canonical/praecepta>`_.

.. code-block:: shell

   make vale

Vale can run against individual files, directories, or globs. To set a specific target:

.. code-block:: shell

    make vale TARGET=example.file
    make vale TARGET=example-directory

.. note::

    Running Vale against a directory will also run against subfolders.

To run against all files with a specific extension within a folder:

.. code-block:: shell

    make vale TARGET=*.md

.. note::

    Wildcards can be used to run against all files matching a string, or an extension. The example above will match against all :code:`.md`
    files, and :code:`TARGET=doc*` will match both :code:`doc_1.md` and :code:`doc_2.md`.

To disable Vale linting within individual files, specific markup can be used.

For Markdown:

.. code-block::

    <!-- vale off -->

    This text will be ignored by Vale.

    <!-- vale on -->

For reStructuredText:

.. code-block::

    .. vale off

    This text will be ignored by Vale.

    .. vale on

Configure the spelling check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The spelling check uses ``aspell``.
Its configuration is located in the ``.sphinx/spellingcheck.yaml`` file.

To add exceptions for words flagged by the spelling check, edit the ``.custom_wordlist.txt`` file.
You shouldn't edit ``.wordlist.txt``, because this file is maintained and updated centrally and contains words that apply across all projects.

Configure the inclusive language check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the inclusive language check is applied only to reST files located
under the documentation directory (usually ``docs``). To check Markdown files,
for example, or to use a location other than the ``docs`` sub-tree, you must
change how the ``woke`` tool is invoked from within ``docs/Makefile`` (see
the `woke User Guide <https://docs.getwoke.tech/usage/#file-globs>`_ for help).

Inclusive language check exemptions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Some circumstances may require you to use some non-inclusive words. In such
cases you will need to create check-exemptions for them.

This page provides an overview of two inclusive language check exemption
methods for files written in reST format. See the `woke documentation`_ for
full coverage.

Exempt a word
.............

To exempt an individual word, place a custom ``none`` role (defined in the
``canonical-sphinx-extensions`` Sphinx extension) anywhere on the line
containing the word in question. The role syntax is:

.. code-block:: none

   :none:`wokeignore:rule=<SOME_WORD>,`

For instance:

.. code-block:: none

   This is your text. The word in question is here: whitelist. More text. :none:`wokeignore:rule=whitelist,`

To exempt an element of a URL, it is recommended to use the standard reST
method of placing links at the bottom of the page (or in a separate file). In
this case, a comment line is placed immediately above the URL line. The comment
syntax is:

.. code-block:: none

   .. wokeignore:rule=<SOME_WORD>

Here is an example where a URL element contains the string "master": :none:`wokeignore:rule=master,`

.. code-block:: none

   .. LINKS
   .. wokeignore:rule=master
   .. _link definition: https://some-external-site.io/master/some-page.html

You can now refer to the label ``link definition_`` in the body of the text.

Exempt an entire file
.....................

A more drastic solution is to make an exemption for the contents of an entire
file. For example, to exempt file ``docs/foo/bar.rst`` add the following line
to file ``.wokeignore``:

.. code-block:: none

   foo/bar.rst

Configure the accessibility check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``pa11y.json`` file at the starter pack root provides basic defaults; to
browse the available settings and options, see ``pa11y``'s `README
<https://github.com/pa11y/pa11y#command-line-configuration>`_ on GitHub.


Configure the link check
~~~~~~~~~~~~~~~~~~~~~~~~

If you have links in the documentation that you don't want to be checked (for
example, because they are local links or give random errors even though they
work), you can add them to the ``linkcheck_ignore`` variable in the ``custom_conf.py`` file.

Add redirects
~~~~~~~~~~~~~

You can add redirects to make sure existing links and bookmarks continue working when you move files around.
To do so, specify the old and new paths in the ``redirects`` setting of the ``custom_conf.py`` file.

Other resources
~~~~~~~~~~~~~~~

- `Example product documentation <https://canonical-example-product-documentation.readthedocs-hosted.com/>`_
- `Example product documentation repository <https://github.com/canonical/example-product-documentation>`_
