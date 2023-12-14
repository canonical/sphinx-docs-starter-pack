===================================
Inclusive language check exemptions
===================================

This page provides an overview of two inclusive language check exemption
methods for files written in reST format. See the `woke documentation`_ for
full coverage.

Exempt a word
-------------

To exempt an individual word, place a comment on a line immediately preceding
the line containing the word in question. This special comment must include the
syntax ``wokeignore:rule=<SOME_WORD>``. For instance:

.. code-block:: none

   .. wokeignore:rule=whitelist
   This is your text. The word in question is here: whitelist. More text.

Here is an example of an exemption that acts upon an element (the string
"master") of a URL. It is recommended to do this by using the standard reST
method of placing the link at the bottom of the page (or in a separate file):

.. code-block:: none

   .. LINKS
   .. wokeignore:rule=master
   .. _link definition: https://some-external-site.io/master/some-page.html

You can now refer to the label ``link definition_`` in the body of the text.

Exempt an entire file
---------------------

A more drastic solution is to make an exemption for the contents of an entire
file. For example, to exempt file ``docs/foo/bar.rst`` add the following line
to file ``.wokeignore``:

.. code-block:: none

   foo/bar.rst

.. LINKS
.. _woke documentation: https://docs.getwoke.tech/ignore
