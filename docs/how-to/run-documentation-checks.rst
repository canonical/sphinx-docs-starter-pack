.. _run-documentation-checks :

Run documentation checks
====================

The starter pack comes with several tests and checks that you can (and should!) run on your documentation before committing and pushing changes.


The avaiable checks are:

- `Accessibility check`_
- `Inclusive language check`_
- `Link check`_
- `Markdown lint check`_
- `Spelling check`_
- `Style guide linting`_


Accessibility check
-------------------

The accessibility check uses `Pa11y`_ to check for accessibility issues in the documentation output.

It is configured to use the `Web Content Accessibility Guidelines (WCAG) 2.2`_, requiring `Level AA conformance`_.

.. note::

   This check is only available locally.


Prerequisites
~~~~~~~~~~~~~

``Pa11y`` must be installed through ``npm``. Install ``npm`` using the appropriate method for your operating system through one of the following methods: 

* Your preferred package manager 
* By following the `node version manager installation process <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm>`_
* For Debian and Ubuntu Linux distributions, the ``sudo apt install npm`` command

Once ``npm`` is installed, install ``Pa11y`` by running this command from within your documentation folder.

.. code-block:: bash

   make pa11y-install

Run
~~~

Run the following command from within your documentation folder.

Look for accessibility issues in rendered documentation::

   make pa11y

Configure
~~~~~~~~~

The :file:`pa11y.json` file in the :file:`.sphinx` folder provides basic defaults.

To browse the available settings and options, see ``Pa11y``'s `README <Pa11y readme_>`_ on GitHub.


Inclusive language check
------------------------

The inclusive language check uses `Vale`_ to check for violations of inclusive language guidelines.

Run
~~~

Run the following command from within your documentation folder::

   make woke

Configure
~~~~~~~~~

By default, the inclusive language check is applied to Markdown and |RST| files located in the documentation folder (usually :file:`docs/`).

Exemptions
~~~~~~~~~~

Sometimes, you might need to use some non-inclusive words.
In such cases, you may exclude them from the check.

Exempt a word in a single instance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To exempt an individual word, give the word the ``woke-ignore`` role::

   :woke-ignore:`<SOME_WORD>`

For instance::

   This is your text. The word in question is here: :woke-ignore:`whitelist`.

.. note::

   Vale will lint the displayed text of a link, not the URL of a link. If you
   wish to use a link that contains non-inclusive language, use appropriate link
   text with the syntax appropriate for your source file. 

Exempt a word globally
^^^^^^^^^^^^^^^^^^^^^^

Vale will ignore any word listed in the ``.custom_wordlist.txt`` file.
To exempt a word, add it to this file globally.

.. note::

   Entries in ``.custom-wordlist`` are case-sensitive only when a capitalised word is used. For instance:

   - Adding ``kustom`` will cause all instances of ``Kustom`` and ``kustom`` to be ignored.
   - Adding ``Kustom`` will cause only instances of ``Kustom`` to be ignored.

Exclude multiple lines from a file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Vale can be switched on and off within a file using syntax appropriate to that
format.


Link check
----------

The link check uses Sphinx to access the links in the documentation output and validate whether they are working.

Run
~~~

Run the following command from within your documentation folder.

Validate links within the documentation::

   make linkcheck

Configure
~~~~~~~~~

If you have links in the documentation that you don't want to be checked (for example, because they are local links or give random errors even though they work), you can add them to the ``linkcheck_ignore`` variable in the :file:`conf.py` file.


Markdown lint check
-------------------

The Markdown lint check is used to enforce standards and consistency in Markdown files.

Run
~~~

Run the following command from within your documentation folder to lint your Markdown files::

   make lint-md

Configure
~~~~~~~~~

You can update the linting rules to enforce in the :file:`.sphinx/.pymarkdown.json` file. Refer to `the pymarkdown rules documentation <https://pymarkdown.readthedocs.io/en/latest/rules/>`_ for all the available rules.


Spelling check
--------------

The spelling check uses ``vale`` to check the spelling in your documentation.
It ignores code (both code blocks and inline code) and URLs (but it does check the link text).

Run
~~~

Run the following commands from within your documentation folder.

Ensure there are no spelling errors in the documentation::

  make spelling

Configure
~~~~~~~~~

The Vale repository `includes a common list of words <https://github.com/canonical/documentation-style-guide/blob/main/styles/config/vocabularies/Canonical/accept.txt>`_ that will be excluded from the check.
To add custom exceptions for your project, add them to the :file:`.custom_wordlist.txt` file.


.. _reference-automatic-checks-spelling-vale-ignore:

Exclude specific terms
~~~~~~~~~~~~~~~~~~~~~~

Sometimes, you need to use a term in a specific context that should usually fail the spelling check.
(For example, you might need to refer to a product called ``ABC Docs``, but you do not want to add ``docs`` to the word list because it isn't a valid word.)

In this case, you can use the ``:vale-ignore:`` role, and ensure your configuration file contains a class association in the ``rst_prolog``::

  rst_prolog = """
  .. role:: vale-ignore
      :class: vale-ignore
  """

Style guide linting
-------------------

The starter pack includes a method to run the `Vale`_ documentation linter configured with `the Vale rules for the current style guide <Vale rules_>`_.


Run
~~~

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
~~~~~~~~~~~~~~~~~

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


Exempt directives
~~~~~~~~~~~~~~~~~

To disable Vale linting for a specific directive, you can apply a class to the section.

For Markdown:

.. code-block:: Markdown

    ````{class} vale-ignore
    ```{code-block}

    This content will be ignored by Vale.
    ```
    ````

.. note::
    
    This should not be necessary for Markdown, as Vale has an expanded scope for ignoring Markdown content by default.

For |RST|:

.. code-block:: rst

    .. class:: vale-ignore
    .. code-block::

        This content will be ignored by Vale.

.. note:: 

    The `.. class::` directive does not need to encapsulate content, it applies to the next logical block (which can be another directive or even a paragraph of content).

Exempt words
~~~~~~~~~~~~

Use the ``:vale-ignore:`` role to ignore specific words inline, but first ensure your configuration file contains a class association in the ``rst_prolog``::

  rst_prolog = """
  .. role:: vale-ignore
      :class: vale-ignore
  """

.. important::

    The spelling check might still flag some terms that contain hyphens or spaces.

    For example, "Juju 3" was unable to be ignored by this method, and `needed to be added to the a specific exception within a rule <https://github.com/canonical/documentation-style-guide/blob/a6f530b07d774bee67dd79d146ae5bbedc9ddef1/styles/Canonical/013-Spell-out-numbers-below-10.yml#L15>`_.





GiHub Workflows
---------------

.. code:: yaml

   jobs:
   [...]
   documentation-checks:
       uses: canonical/documentation-workflows/.github/workflows/documentation-checks.yaml@main
       with:
         working-directory: 'docs'


Check for removed URLs
~~~~~~~~~~~~~~~~~~~~~~

.. versionadded:: 1.2.0

The starter pack includes a GitHub action to
identify when page URLs have been removed. This includes moving pages to another
path, or removing them completely.

This does not cover higher-level changes to URL paths, such as changing the RTD 
project name, or language and versioning structure provided by RTD.

This check is available to ensure that redirects are implemented when pages are
moved, or appropriate information can be provided when anything is removed.