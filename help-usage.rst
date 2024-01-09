====================
Use the starter pack
====================

This page is for documentation contributors. It assumes that the current
repository has been initialised with the starter pack as described in
:doc:`help-enable`.

There are make targets defined in the ``Makefile`` that do various things. To
get started, we will:

* install prerequisite software
* view the documentation

Install prerequisite software
-----------------------------

To install the prerequisites:

.. code-block:: none

   make install

This will create a virtual environment (``.sphinx/venv``) and install
dependency software (``.sphinx/requirements.txt``) within it.

**Note**:
By default, the starter pack uses the latest compatible version of all tools and does not pin its requirements.
This might change temporarily if there is an incompatibility with a new tool version.
There is therefore no need in using a tool like Renovate to automatically update the requirements.

View the documentation
----------------------

To view the documentation:

.. code-block:: none

   make run

This will do several things:

* activate the virtual environment
* build the documentation
* serve the documentation on **127.0.0.1:8000**
* rebuild the documentation each time a file is saved
* send a reload page signal to the browser when the documentation is rebuilt

The ``run`` target is therefore very convenient when preparing to submit a
change to the documentation.

.. note:: 

   If you encounter the error ``locale.Error: unsupported locale setting`` when activating the Python virtual environment, include the environment variable in the command and try again: ``LC_ALL=en_US.UTF-8 make run``

Local checks
------------

Before committing and pushing changes, it's a good practice to run various checks locally to catch issues early in the development process.

Local build
~~~~~~~~~~~

Run a clean build of the docs to surface any build errors that would occur in RTD:

.. code-block:: none

   make clean-doc
   make html

Spelling check
~~~~~~~~~~~~~~

Ensure there are no spelling errors in the documentation:

.. code-block:: shell

   make spelling

Inclusive language check
~~~~~~~~~~~~~~~~~~~~~~~~

Ensure the documentation uses inclusive language:

.. code-block:: shell

   make woke

Link check
~~~~~~~~~~

Validate links within the documentation:

.. code-block:: shell

   make linkcheck

Configure the spelling check
----------------------------

The spelling check uses ``aspell``.
Its configuration is located in the ``.sphinx/spellingcheck.yaml`` file.

To add exceptions for words flagged by the spelling check, edit the ``.custom_wordlist.txt`` file.
You shouldn't edit ``.wordlist.txt``, because this file is maintained and updated centrally and contains words that apply across all projects.

Customisation of inclusive language checks
------------------------------------------

By default, the inclusive language check is applied only to reST files located
under the documentation directory (usually ``docs``). To check Markdown files,
for example, or to use a location other than the ``docs`` sub-tree, you must
change how the ``woke`` tool is invoked from within ``docs/Makefile`` (see
the `woke User Guide <https://docs.getwoke.tech/usage/#file-globs>`_ for help).

Some circumstances may require you to use some non-inclusive words. In such
cases you will need to create check-exemptions for them. See file
:doc:`help-woke` for how to do that.

Configure the link check
------------------------

If you have links in the documentation that you don't want to be checked (for
example, because they are local links or give random errors even though they
work), you can add them to the ``linkcheck_ignore`` variable in the ``custom_conf.py`` file.

Add redirects
-------------

You can add redirects to make sure existing links and bookmarks continue working when you move files around.
To do so, specify the old and new paths in the ``redirects`` setting of the ``custom_conf.py`` file.

Other resources
---------------

- `Example product documentation <https://canonical-example-product-documentation.readthedocs-hosted.com/>`_
- `Example product documentation repository <https://github.com/canonical/example-product-documentation>`_
