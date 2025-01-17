.. _automatic-checks-inclusivelanguage:

Inclusive language check
========================

The inclusive language check uses `woke`_ to check for violations of inclusive language guidelines.

Install prerequisite software
-----------------------------

The following two commands can be run from any location on your system.

To install ``woke``, you need ``snap``::

   sudo apt install snapd

To install ``woke``:

.. code-block:: bash

   make woke-install

Run the inclusive language check
--------------------------------

Run the following command from within your documentation folder.

Ensure the documentation uses inclusive language::

   make woke

Configure the inclusive language check
--------------------------------------

By default, the inclusive language check is applied only to |RST| files located in the documentation folder (usually :file:`docs/`).
To check Markdown files, for example, or to use a location other than the :file:`docs/` sub-tree, you must override the ``ALLFILES`` variable in :file:`Makefile.sp`.

You can find more information about available options in the `woke User Guide`_.

Inclusive language check exemptions
-----------------------------------

Sometimes, you might need to use some non-inclusive words.
In such cases, create check exemptions for them.

See the `woke documentation`_ for how to do this.
The following sections provide some examples.

Exempt a word
~~~~~~~~~~~~~

To exempt an individual word, place a custom ``none`` role (defined in the ``canonical-sphinx-extensions`` Sphinx extension) anywhere on the line containing the word in question.
The role syntax is::

   :none:`wokeignore:rule=<SOME_WORD>,`

For instance::

   This is your text. The word in question is here: whitelist. More text. :none:`wokeignore:rule=whitelist,`

To exempt an element of a URL, use the standard |RST| method of placing links at the bottom of the page (or in a separate file) and place a comment line immediately above the URL line.
The comment syntax is::

   .. wokeignore:rule=<SOME_WORD>

Here is an example where a URL element contains the string "master": :none:`wokeignore:rule=master,`

.. code-block:: none

   .. LINKS
   .. wokeignore:rule=master
   .. _link definition: https://some-external-site.io/master/some-page.html

You can now refer to the label ``link definition_`` in the body of the text.

Exempt an entire file
~~~~~~~~~~~~~~~~~~~~~

A more drastic solution is to make an exemption for the contents of an entire file.
For example, to exempt file :file:`docs/foo/bar.rst`, add the following line to the file :file:`.wokeignore`::

   foo/bar.rst
