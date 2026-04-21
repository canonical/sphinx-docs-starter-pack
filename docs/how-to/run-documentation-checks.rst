.. _run-documentation-checks :

Run documentation checks
========================

The starter pack comes with several tests and checks that you can (and should!) run on your documentation before committing and pushing changes:


- :ref:`accessibility_check`
- :ref:`inclusive_lang_check`
- :ref:`link_check`
- :ref:`markdown_lint_check`
- :ref:`spelling_check`
- :ref:`style_guide_linting`
- :ref:`vale_exemptions`

.. _accessibility_check:

Accessibility check
-------------------

The Starter Pack checks the accessibility of the documentation with `Pa11y`_. It's configured to check for Level AA conformity to the `Web Content Accessibility Guidelines (WCAG) 2.2`_.

This check is only available locally; it is not part of the Starter Pack's :ref:`github-workflows`.

To run the check, you must have ``npm`` and ``Pa11y`` installed. To install ``npm``, refer to the `installation guide <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm>`__ for details. Then:

.. code-block:: bash

    npm install pa11y


To check the accessibility of the documentation, run the following command from within your ``/docs`` directory:

.. code-block:: bash

    make pa11y

Configure
~~~~~~~~~

The ``pa11y.json`` file in the ``.sphinx`` directory provides basic defaults expected to be used for all teams; refrain from removing any unless absolutely necessary. Additional settings and options are detailed in the ``Pa11y`` `README <https://github.com/pa11y/pa11y#command-line-configuration>`__ on GitHub.

.. _inclusive_lang_check:

Inclusive language check
------------------------

The Starter Pack checks for inclusive language with a custom set of `Vale`_ rules. To check for inclusive language violations, run:

.. code-block:: bash

    make woke

Configure
~~~~~~~~~

If you need to exempt single words or sections, follow the process in :ref:`vale_exemptions`. 

.. _link_check:

Link check
----------

The Starter Pack checks any links in your documentation with the Sphinx ``linkcheck`` builder. To validate the links, run:

.. code-block:: bash

    make linkcheck

Configure
~~~~~~~~~

If you have links in the documentation that you don't want to check, add them to the ``linkcheck_ignore`` list in the ``conf.py`` file.

.. _markdown_lint_check:

Markdown lint check
-------------------

The Starter Pack checks standards and consistency in Markdown files with the Markdown lint check. To check your Markdown files, run:

.. code-block:: bash

    make lint-md

Configure
~~~~~~~~~

You can update the linting rules in the ``.sphinx/.pymarkdown.json`` file. Refer to `the pymarkdown rules documentation <https://pymarkdown.readthedocs.io/en/latest/rules/>`_ for all the available rules.


.. _spelling_check:

Spelling check
--------------

The Starter Pack uses `Vale`_ to check the spelling in your documentation. It ignores inline code, code blocks, and URLs, but it does check the link text. To ensure there are no spelling errors in your documentation, run:

.. code-block:: bash

    make spelling

Configure
~~~~~~~~~

If you need to exempt single words or sections, follow the process in :ref:`vale_exemptions`. 

.. _style_guide_linting:

Style guide linting
-------------------

The Starter Pack runs the `Vale`_ documentation linter configured with the rules of `style guide <https://github.com/canonical/documentation-style-guide>`__ To check your documentation with Vale, run:

.. code-block:: bash

    make vale

Vale can run against individual files, directories, or globs. To check a specific target, run:

.. code-block:: bash

    make vale TARGET=example.file
    make vale TARGET=example-directory

If you run the linter against a directory, its subdirectories ware also linted.

You can use wildcards to lint globs of files. For example, to run against all Markdown files within a directory, you'd run:

.. code-block:: bash

    make vale TARGET=*.md

Configure
~~~~~~~~~

If you need to exempt single words or sections, follow the process in :ref:`vale_exemptions`. 

.. _vale_exemptions:
.. _reference-automatic-checks-spelling-vale-ignore:

Vale exemptions
---------------

The :ref:`inclusive_lang_check`, :ref:`spelling_check`, and :ref:`style_guide_linting` all use `Vale`_. These checks share a common syntax for exemptions and pull from the same ``.custom_wordlist.txt`` file. The style guide repository `includes a common list of words <https://github.com/canonical/documentation-style-guide/blob/main/styles/config/vocabularies/Canonical/accept.txt>`__ that will be excluded from the checks. 

A word
~~~~~~

To ignore a single instance of a word, wrap it in the ``:vale-ignore:`` role. Ensure your ``conf.py`` file contains the appropriate class association in the ``rst_prolog``:

.. code-block:: text

    rst_prolog = """
    .. role:: vale-ignore
        :class: vale-ignore
    """

To ignore a word across your documentation, add it to your project's ``.custom_wordlist.txt`` file.

.. note::

   Entries in ``.custom-wordlist`` are case-sensitive only when the word is capitalized. For instance:

   - Adding ``kustom`` will cause all instances of ``Kustom`` and ``kustom`` to be ignored.
   - Adding ``Kustom`` will cause only instances of ``Kustom`` to be ignored.


A section of text
~~~~~~~~~~~~~~~~~

To disable Vale for a section of text, use the following markup:

.. tab-set:: 

    .. tab-item:: Markdown

        .. code-block:: text

            <!-- vale off -->

            This text will be ignored.

            <!-- vale on -->
    
    .. tab-item:: reST

        .. code-block:: text

            .. vale off

            This text will be ignored.

            .. vale on



Directives
~~~~~~~~~~

To disable Vale linting for Directives as a code block or admonitions, apply the `vale-ignore` class to the section:

.. tab-set:: 

    .. tab-item:: Markdown

        .. code-block:: text

            ````{class} vale-ignore
            ```{code-block}

            This content will be ignored by Vale.
            ```
            ````
    
    .. tab-item:: reST

        .. code-block:: text

            .. class:: vale-ignore
                .. code-block::

                    This content will be ignored by Vale.

The class process isn't be necessary for Markdown, as Vale has an expanded scope for ignoring Markdown content by default. Also, the `.. class::` directive for reST does not need to encapsulate content, it applies to the next logical block (which can be another directive or even a paragraph of content). The class option should only be used when other options aren't suitable.

.. note::

    The checks may flag terms that contain hyphens or spaces.

    For example, "Juju 3" wasn't ignored by default, and `needed to be added to be excepted with an upstream rule <https://github.com/canonical/documentation-style-guide/blob/a6f530b07d774bee67dd79d146ae5bbedc9ddef1/styles/Canonical/013-Spell-out-numbers-below-10.yml#L15>`_.
