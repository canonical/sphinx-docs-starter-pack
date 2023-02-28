:orphan:
:relatedlinks: https://github.com/canonical/lxd-sphinx-extensions

=========================
Documentation cheat sheet
=========================

The documentation files use `reStructuredText (rST) <https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html>`_ syntax. |x wokeignore:rule=master x|

See the following sections for syntax help and conventions.

Headings
========

.. list-table::
   :header-rows: 1

   * - Input
     - Description
   * - .. code::

          Title
          =====
     - Page title and H1 heading
   * - .. code::

          Heading
          -------
     - H2 heading
   * - .. code::

          Heading
          ^^^^^^^
     - H3 heading
   * - Underlines with other characters, for example, ``"``, ``~``, ``#`` or ``*``
     - Further headings

Underlines must be at least as long as the title or heading.

Adhere to the following conventions:

- Do not use consecutive headings without intervening text.
- Use sentence style for headings (capitalise only the first word).

Inline formatting
=================

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``:guilabel:`UI element```
     - :guilabel:`UI element`
   * - ````code````
     - ``code``
   * - ``:file:`file path```
     - :file:`file path`
   * - ``:command:`command```
     - :command:`command`
   * - ``*Italic*``
     - *Italic*
   * - ``**Bold**``
     - **Bold**

Adhere to the following conventions:

- Use italics sparingly. Common uses for italics are titles and names (for example, when referring to a section title that you cannot link to, or when introducing the name for a concept).
- Use bold sparingly. Avoid using bold for emphasis and rather rewrite the sentence to get your point across.

Code blocks
===========

To start a code block, either end the introductory paragraph with two colons (``::``) and indent the following code block, or explicitly start a code block with ``.. code::``.

When explicitly starting a code block, you can specify the code language to enforce a specific lexer, but in many cases, the default lexer works just fine.


.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          Demonstrate a code block::

            code:
             - example: true
     - Demonstrate a code block::

         code:
         - example: true
   * - .. code::

          .. code::

             # Demonstrate a code block
             code:
             - example: true
     - .. code::

          # Demonstrate a code block
          code:
          - example: true
   * - .. code::

          .. code:: yaml

             # Demonstrate a code block
             code:
             - example: true
     - .. code:: yaml

          # Demonstrate a code block
          code:
          - example: true

Links
=====

How to link depends on if you are linking to an external URL or to another page in the documentation.

External links
--------------

For external links, use the following syntax:

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ```Canonical website <https://canonical.com/>`_``
     - `Canonical website <https://canonical.com/>`_

It is also possible to use only the link without any markup.
However, that will usually cause an error in the spelling checker.

To display a URL as text and prevent it from being linked, add an escaped space character (``http:\ //``; the space will not be visible):

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``https:\ //canonical.com/``
     - :spellexception:`https://canonical.com/`

Internal references
-------------------

You can reference pages and targets in this documentation set, and also in other documentation sets using Intersphinx.

.. _a_section_target:

Referencing a section
^^^^^^^^^^^^^^^^^^^^^

To reference a section within the documentation (either on the same page or on another page), add a target to that section and reference that target.

.. _a_random_target:

You can add targets at any place in the documentation. However, if there is no heading or title for the targeted element, you must specify a link text.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
     - Description
   * - ``.. _target_ID:``
     -
     - Adds the target ``target_ID``.

       .. note::
          When defining the target, you must prefix it with an underscore. Do not use the starting underscore when referencing the target.
   * - ``:ref:`a_section_target```
     - :ref:`a_section_target`
     - References a target that has a title.
   * - ``:ref:`Link text <a_random_target>```
     - :ref:`Link text <a_random_target>`
     - References a target and specifies a title.
   * - ``:ref:`sphinx-rtd:home```
     - :ref:`sphinx-rtd:home`
     - You can also reference targets in other doc sets.

Adhere to the following conventions:

- Never use external links to reference a section in the same doc set or a doc set that is linked with Intersphinx. It would likely cause a broken link in the future.
- Override the link text only when it is necessary. If you can use the referenced title as link text, do so, because the text will then update automatically if the title changes.
- Never "override" the link text with the same text that would be generated automatically.

Referencing a page
^^^^^^^^^^^^^^^^^^

If a documentation page does not have a target, you can still reference it by using the ``:doc:`` role with the file name and path.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``:doc:`tutorial/install```
     - :doc:`tutorial/install`
   * - ``:doc:`Link text <tutorial/install>```
     - :doc:`Link text <tutorial/install>`
   * - ``:doc:`sphinx-rtd:setup-rtd```
     - :doc:`sphinx-rtd:setup-rtd`
   * - ``:doc:`Link text <sphinx-rtd:setup-rtd>```
     - :doc:`Link text <sphinx-rtd:setup-rtd>`

Adhere to the following conventions:

- Only use the ``:doc:`` role when you cannot use the ``:ref:`` role, thus only if there is no target at the top of the file and you cannot add it. When using the ``:doc:`` role, your reference will break when a file is renamed or moved.
- Override the link text only when it is necessary. If you can use the document title as link text, do so, because the text will then update automatically if the title changes.
- Never "override" the link text with the same text that would be generated automatically.

Navigation
==========

Every documentation page must be included as a sub-page to another page in the navigation.

This is achieved with the `toctree <https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree>`_ |x wokeignore:rule=master x| directive in the parent page::

  .. toctree::
     :hidden:

     sub-page1
     sub-page2

If a page should not be included in the navigation, you can suppress the resulting build warning by putting ``:orphan:`` at the top of the file.
Use orphan pages sparingly and only if there is a clear reason for it.

Lists
=====

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          - Item 1
          - Item 2
          - Item 3
     - - Item 1
       - Item 2
       - Item 3
   * - .. code::

          1. Step 1
          #. Step 2
          #. Step 3
     - 1. Step 1
       #. Step 2
       #. Step 3
   * - .. code::

          a. Step 1
          #. Step 2
          #. Step 3
     - a. Step 1
       #. Step 2
       #. Step 3

You can also nest lists:

.. tabs::

   .. group-tab:: Input

      .. code::

         1. Step 1

            - Item 1

              * Sub-item
            - Item 2

              i. Sub-step 1
              #. Sub-step 2
         #. Step 2

            a. Sub-step 1

               - Item
            #. Sub-step 2
   .. group-tab:: Output



       1. Step 1

          - Item 1

            * Sub-item
          - Item 2

            i. Sub-step 1
            #. Sub-step 2
       #. Step 2

          a. Sub-step 1

             - Item
          #. Sub-step 2



Adhere to the following conventions:

- In numbered lists, number the first item and use ``#.`` for all subsequent items to generate the step numbers automatically.
- Use ``-`` for unordered lists. When using nested lists, you can use ``*`` for the nested level.

Definition lists
----------------

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          Term 1:
            Definition
          Term 2:
            Definition
     - Term 1:
         Definition
       Term 2:
         Definition

Tables
======

rST supports different markup for tables. Grid tables are most similar to tables in Markdown, but list tables are usually much easier to use.
See the `Sphinx documentation <https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#table-directives>`_ for all table syntax alternatives. |x wokeignore:rule=master x|

Both markups result in the following output:

.. list-table::
   :header-rows: 1

   * - Header 1
     - Header 2
   * - Cell 1

       Second paragraph cell 1
     - Cell 2
   * - Cell 3
     - Cell 4

Grid tables
-----------

See `Grid Tables <https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#grid-tables>`_ for reference.

.. code::

   +----------------------+------------+
   | Header 1             | Header 2   |
   +======================+============+
   | Cell 1               | Cell 2     |
   |                      |            |
   | 2nd paragraph cell 1 |            |
   +----------------------+------------+
   | Cell 3               | Cell 4     |
   +----------------------+------------+

List tables
-----------

See `List table <https://docutils.sourceforge.io/docs/ref/rst/directives.html#list-table>`_ for reference.

.. code::

   .. list-table::
      :header-rows: 1

      * - Header 1
        - Header 2
      * - Cell 1

          2nd paragraph cell 1
        - Cell 2
      * - Cell 3
        - Cell 4

Notes
=====

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. note::
             A note.
     - .. note::
          A note.
   * - .. code::

          .. tip::
             A tip.
     - .. tip::
          A tip.
   * - .. code::

          .. important::
             Important information
     - .. important::
          Important information
   * - .. code::

          .. caution::
             This might damage your hardware!
     - .. caution::
          This might damage your hardware!

Adhere to the following conventions:

- Use notes sparingly.
- Only use the following note types: ``note``, ``tip``, ``important``, ``caution``
- Only use a caution if there is a clear hazard of hardware damage or data loss.

Images
======

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``.. image:: https://assets.ubuntu.com/v1/b3b72cb2-canonical-logo-166.png``
     - .. image:: https://assets.ubuntu.com/v1/b3b72cb2-canonical-logo-166.png
   * - .. code::

          .. figure:: https://assets.ubuntu.com/v1/b3b72cb2-canonical-logo-166.png
             :width: 100px
             :alt: Alt text

             Figure caption
     - .. figure:: https://assets.ubuntu.com/v1/b3b72cb2-canonical-logo-166.png
          :width: 100px
          :alt: Alt text

          Figure caption

Adhere to the following conventions:

- For local pictures, start the path with :file:`/` (for example, :file:`/images/image.png`).
- Use ``PNG`` format for screenshots and ``SVG`` format for graphics.

Reuse
=====

A big advantage of rST in comparison to plain Markdown is that it allows to reuse content.

Substitution
------------

To reuse sentences or paragraphs without too much markup and special formatting, use substitutions.

Substitutions can be defined in the following locations:

- In the :file:`reuse/substitutions.txt` file. Substitutions defined in this file are available in all documentation pages.
- In any rST file in the following format::

     .. |reuse_key| replace:: This is **included** text.

.. |reuse_key| replace:: This is **included** text.

You cannot override a substitution by defining it twice.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``|reuse_key|``
     - |reuse_key|
   * - ``|demo|``
     - |demo|

Adhere to the following convention:

- Use key names that indicate the included text (for example, ``note_not_supported`` instead of ``reuse_note``).

File inclusion
--------------

To reuse longer sections or text with more advanced markup, you can put the content in a separate file and include the file or parts of the file in several locations.

To select parts of the text in a file, use ``:start-after:`` and ``:end-before:`` if possible. You can combine those with ``:start-line:`` and ``:end-line:`` if required (if the same text occurs more than once). Using only ``:start-line:`` and ``:end-line:`` is error-prone though.

You cannot put any targets into the content that is being reused (because references to this target would be ambiguous then). You can, however, put a target right before including the file.

By combining file inclusion and substitutions defined directly in a file, you can even replace parts of the included text.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. include:: reference/index.rst
             :start-after: lacus at tempus.
             :end-before: Mauris volutpat
     - .. include:: reference/index.rst
          :start-after: lacus at tempus.
          :end-before: Mauris volutpat

Adhere to the following conventions:

- Files that only contain text that is reused somewhere else should be placed in the :file:`reuse` folder and end with the extension ``.txt`` to distinguish them from normal content files.
- To make sure inclusions don't break, consider adding comments (``.. some comment``) to the source file as markers for starting and ending.

Tabs
====

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. tabs::

             .. group-tab:: Tab 1

                Content Tab 1

             .. group-tab:: Tab 2

                Content Tab 2
     - .. tabs::

          .. group-tab:: Tab 1

             Content Tab 1

          .. group-tab:: Tab 2

             Content Tab 2


Glossary
========

You can define glossary terms in any file. Ideally, all terms should be collected in one glossary file though, and they can then be referenced from any file.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. glossary::

             example term
               Definition of the example term.
     - .. glossary::

          example term
            Definition of the example term.
   * - ``:term:`example term```
     - :term:`example term`

More useful markup
==================

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. versionadded:: X.Y
     - .. versionadded:: X.Y
   * - .. code::

          | Line 1
          | Line 2
          | Line 3
     - | Line 1
       | Line 2
       | Line 3
   * - ``.. This is a comment``
     - .. This is a comment
   * - ``:abbr:`API (Application Programming Interface)```
     - :abbr:`API (Application Programming Interface)`

Custom extensions
=================

The starter pack includes some custom extensions that you can use.

Related links
-------------

You can add links to related websites to the sidebar by adding the following field at the top of the page::

  :relatedlinks: https://github.com/canonical/lxd-sphinx-extensions, [RTFM](https://www.google.com)

To override the title, use Markdown syntax. Note that spaces are ignored; if you need spaces in the title, replace them with ``&#32;``, and include the value in quotes if Sphinx complains about the metadata value because it starts with ``[``.

To add a link to a Discourse topic, configure the Discourse instance in the :file:`conf.py` file.
Then add the following field at the top of the page (where ``12345`` is the ID of the Discourse topic)::

  :discourse: 12345

YouTube links
-------------

To add a link to a YouTube video, use the following directive:

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code::

          .. youtube:: https://www.youtube.com/watch?v=iMLiK1fX4I0
             :title: Demo

     - .. youtube:: https://www.youtube.com/watch?v=iMLiK1fX4I0
          :title: Demo

The video title is extracted automatically and displayed when hovering over the link.
To override the title, add the ``:title:`` option.

Spelling exceptions
-------------------

If you need to use a word that does not comply to the spelling conventions, but is correct in a certain context, you can exempt it from the spelling checker by surrounding it with ``:spellexception:``.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``:spellexception:\`PurposelyWrong\```
     - :spellexception:`PurposelyWrong`
