.. _automatic-checks-accessibility:

Accessibility check
===================

The accessibility check uses `Pa11y`_ to check for accessibility issues in the documentation output.

It is configured to use the `Web Content Accessibility Guidelines (WCAG) 2.2`_, requiring `Level AA conformance`_.

.. note::

   The accessibility check is not yet required, since there are some issues within the starter pack itself.
   We are working on resolving those.

   For now, the check is implemented as non-blocking as part of our GitHub workflow.

Install prerequisite software
-----------------------------

``Pa11y`` must be installed through ``npm``::

   sudo apt install npm

To install ``Pa11y``:

.. code-block:: bash

   make pa11y-install

Run the accessibility check
---------------------------

Look for accessibility issues in rendered documentation::

   make pa11y

Configure the accessibility check
---------------------------------

The :file:`pa11y.json` file in the :file:`.sphinx` directory provides basic defaults.

To browse the available settings and options, see ``Pa11y``'s `README <Pa11y readme_>`_ on GitHub.
