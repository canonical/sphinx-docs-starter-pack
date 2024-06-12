Quickstart guide
----------------

An initial set of documentation can be built directly from a clone of this
repository.

First, clone this repository to a local directory, and change to this
directory:

.. code-block:: sh

   git clone git@github.com:canonical/sphinx-docs-starter-pack <new-repository-name>
   cd <new-repository-name>

Now build the documentation with the following command. This will create a virtual
environment, install the software dependencies, and build the documentation:

.. code-block:: sh

   make run

Keep this session running to rebuild the documentation automatically whenever a
file is saved, and open |http://127.0.0.1:8000|_ in a web browser to see the
locally built and hosted HTML.

To add a new page to the documentation, create a new document called
``reference.rst`` in a text editor and insert the following reST-formatted
``Reference``  heading:

.. code-block:: rest

    Reference
    =========

Now save ``reference.rst`` and open ``index.rst``.

At the bottom of this file, add an indented line containing ``Reference
<reference>`` to the end of the ``toctree`` section. This is the navigation
title for the new document and its filename without the ``.rst`` extension.

The ``toctree`` section will now look like this:

.. code-block:: rest

    .. toctree::
       :hidden:
       :maxdepth: 2

       ReadMe <readme>
       Reference <reference>

Save ``index.rst`` and reload |http://127.0.0.1:8000|_.

The documentation will now show **Reference** added to the navigation and
selecting this will open the new ``reference.rst`` document.
