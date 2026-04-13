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

Note that this check is only available locally; it is not part of the Starter Pack's :ref:`github-workflows`.


**Prerequisites:** ``Pa11y`` must be installed through ``npm``. Install ``npm`` with the appropriate method for your operating system; follow the `npm docs installation guide <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm>`_ for details. 


To check the accessibility of the documentation, run the following command from within your ``/docs`` directory:

.. code-block:: bash

    make pa11y



Configure
~~~~~~~~~

The ``pa11y.json`` file in the ``.sphinx`` directory provides basic defaults expected to be used for all teams; refrain from removing any unless absolutely necessary. To include additional checks, browse the available settings and options on ``Pa11y``'s `README <Pa11y readme_>`_ on GitHub.

.. _inclusive_lang_check:

Inclusive language check
------------------------

The Starter Pack checks for inclusive language with a custom set of `Vale`_ rules. To check for inclusive language violations, run:

.. code-block:: bash

    make woke

For options on exempting single words or sections, follow the process in the :ref:`vale_exemptions` section. 

.. _link_check:

Link check
----------

The Starter Pack checks any links in your documentation with the Sphinx ``linkcheck`` builder. To validate the links, run:

.. code-block:: bash

   make linkcheck

Configure
~~~~~~~~~

If you have links in the documentation that you don't want to check, you can add them to the ``linkcheck_ignore`` variable in the ``conf.py`` file.

.. _markdown_lint_check:

Markdown lint check
-------------------

The Starter Pack checks standards and consistency in Markdown files with the Markdown lint check. To check your Markdown files, run:

.. code-block:: bash

   make lint-md

Configure
~~~~~~~~~

You can update the linting rules to be enforced in the ``.sphinx/.pymarkdown.json`` file. Refer to `the pymarkdown rules documentation <https://pymarkdown.readthedocs.io/en/latest/rules/>`_ for all the available rules.


.. _spelling_check:

Spelling check
--------------

The Starter Pack uses `Vale`_ to check the spelling in your documentation. It ignores code (both code blocks and inline code) and URLs (but it does check the link text). To ensure there are no spelling errors in your documentation, run:

.. code-block:: bash

  make spelling

For options on exempting single words or sections, follow the process in the :ref:`vale_exemptions` section. 

.. _style_guide_linting:

Style guide linting
-------------------

The Starter Pack includes a method to run the `Vale`_ documentation linter configured with `the Vale rules for the current style guide <Vale rules_>`_ To check your documentation with, run:

.. code-block:: bash

   make vale

Vale can run against individual files, directories, or globs. To check a specific target, run:

.. code-block:: bash

    make vale TARGET=example.file
    make vale TARGET=example-directory

Note that running the linter against a directory will also run against its subdirectories.

You can use wildcards to run against all files matching a string, or an extension. For example, to run against all :code:`.md` files within a directory:

.. code-block:: bash

    make vale TARGET=*.md

For options on exempting single words or sections, follow the process in the :ref:`vale_exemptions` section. 

.. _vale_exemptions:
.. _reference-automatic-checks-spelling-vale-ignore:

Vale exemptions
---------------

The :ref:`inclusive_lang_check`, :ref:`spelling_check`, and :ref:`style_guide_linting` all use `Vale`_ and share a common ``.custom_wordlist.txt`` file and follow the same process to add exemptions. The Vale repository `includes a common list of words <https://github.com/canonical/documentation-style-guide/blob/main/styles/config/vocabularies/Canonical/accept.txt>`_ that will be excluded from the checks. 

Note that Vale will check the displayed text of a link, not the URL of a link. If you wish to use a link that contains non-inclusive language or incorrect spelling, use appropriate link text with the syntax appropriate for your source file. 

A single instance of a word
~~~~~~~~~~~~~~~~~~~~~~~~~~~
To ignore only a single instance of a word, you can use the ``:vale-ignore:`` role (for spelling or style guide) or ``:woke-ignore:`` role (for inclusive language) and ensure your ``conf.py`` file contains the appropriate class association in the ``rst_prolog``:

.. code-block:: text

  rst_prolog = """
  .. role:: vale-ignore
      :class: vale-ignore
  .. role:: woke-ignore
      :class: woke-ignore
  """

Every instance of a word
~~~~~~~~~~~~~~~~~~~~~~~~
To ignore a word across your documentation, add the word to the custom exceptions for your project in the ``.custom_wordlist.txt`` file.

.. note::

   Entries in ``.custom-wordlist`` are case-sensitive only when a capitalised word is used. For instance:

   - Adding ``kustom`` will cause all instances of ``Kustom`` and ``kustom`` to be ignored.
   - Adding ``Kustom`` will cause only instances of ``Kustom`` to be ignored.


A section of text
~~~~~~~~~~~~~~~~~
To disable Vale for a specific section of text, specific markup can be used:

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



A specific directive block
~~~~~~~~~~~~~~~~~~~~~~~~~~

To disable Vale linting for a specific directive, such as a code block or note, you can apply a class to the section:

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

Note that the class process should not be necessary for Markdown, as Vale has an expanded scope for ignoring Markdown content by default. Also, the `.. class::` directive for reST does not need to encapsulate content, it applies to the next logical block (which can be another directive or even a paragraph of content). The class option should only be used when the other options are not suitable.

.. important::

    The checks might still flag some terms that contain hyphens or spaces.

    For example, "Juju 3" was unable to be ignored by this method, and `needed to be added to the a specific exception within a rule <https://github.com/canonical/documentation-style-guide/blob/a6f530b07d774bee67dd79d146ae5bbedc9ddef1/styles/Canonical/013-Spell-out-numbers-below-10.yml#L15>`_.
