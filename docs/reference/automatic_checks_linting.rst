.. _automatic-checks-linting:

Lint check
==========

Markdown
--------

The Markdown lint check is used to enforce standards and consistency in Markdown files.

Run the lint check
~~~~~~~~~~~~~~~~~~

Run the following command from within your documentation folder to lint your Markdown files::

   make lint-md

Configure the lint check
~~~~~~~~~~~~~~~~~~~~~~~~

You can update the linting rules to enforce in the :file:`.sphinx/.pymarkdown.json` file. Refer to `the pymarkdown rules documentation <https://pymarkdown.readthedocs.io/en/latest/rules/>`_ for all the available rules.
