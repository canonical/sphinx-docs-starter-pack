.. _automatic-checks-spelling:

Spelling check
==============

The spelling check uses ``vale`` to check the spelling in your documentation.
It ignores code (both code blocks and inline code) and URLs (but it does check the link text).

Run the spelling check
----------------------

Run the following commands from within your documentation folder.

Ensure there are no spelling errors in the documentation::

  make spelling

Configure the spelling check
----------------------------

The Vale repository `includes a common list of words <https://github.com/canonical/documentation-style-guide/blob/main/styles/config/vocabularies/Canonical/accept.txt>`_ that will be excluded from the check.
To add custom exceptions for your project, add them to the :file:`.custom_wordlist.txt` file.

Exclude specific terms
----------------------

Sometimes, you need to use a term in a specific context that should usually fail the spelling check.
(For example, you might need to refer to a product called ``ABC Docs``, but you do not want to add ``docs`` to the word list because it isn't a valid word.)

In this case, you can use the ``:vale-ignore:`` role, and ensure your configuration file contains a class association in the ``rst_prolog``::

  rst_prolog = """
  .. role:: vale-ignore
      :class: vale-ignore
  """