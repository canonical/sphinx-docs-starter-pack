.. _automatic-checks-styleguide:

Style guide linting
===================

The starter pack includes a method to run the `Vale`_ documentation linter configured with `the Vale rules for the current style guide <Vale rules_>`_.


Run the style guide linting
---------------------------

Run the following commands from within your documentation folder.

Check documentation with Vale::

   make vale

Vale can run against individual files, folders, or globs.
To set a specific target::

    make vale TARGET=example.file
    make vale TARGET=example-folder

.. note::

    Running Vale against a folder will also run against its subfolders.

You can use wildcards to run against all files matching a string, or an extension.

For example, to run against all :code:`.md` files within a folder::

    make vale TARGET=*.md

To match, for example, :code:`doc_1.md` and :code:`doc_2.md`::

    make vale TARGET=doc*


Exempt paragraphs
-----------------

To disable Vale linting within individual files, specific markup can be used.

For Markdown:

.. code-block:: Markdown

   <!-- vale off -->

   This text will be ignored by Vale.

   <!-- vale on -->

For |RST|:

.. code-block:: rest

   .. vale off

   This text will be ignored by Vale.

   .. vale on
