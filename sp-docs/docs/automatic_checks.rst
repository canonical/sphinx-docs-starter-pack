.. _automatic-checks:

Automatic checks
================

The starter pack comes with several automatic checks that you can (and should!) run on your documentation before committing and pushing changes.

The following checks are available:

.. toctree::
   :maxdepth: 1
   :glob:

   /docs/automatic_checks_*

Install prerequisite software
-----------------------------

Some of the tools used by the automatic checks might not be available by default on your system.
To install them, you need ``snap`` and ``npm``::

   sudo apt install npm snapd

To install the validation tools:

.. code-block:: bash

   make woke-install
   make pa11y-install
