.. _how-to-openapi:

Add OpenAPI integration
=======================

Use this guide to add a minimal OpenAPI integration for the starter pack.
This implementation uses `Swagger UI <https://swagger.io/tools/swagger-ui/>`_;
it includes a basic specification and an opt-in tag toggle,
based on a build-time environment variable,
to keep the documentation clean by default.

Locate the specification
------------------------

The stub OpenAPI document can be found under ``docs/how-to/assets/openapi.yaml``.
You can reuse it as a starting point for your API description:

.. literalinclude:: assets/openapi.yaml
   :language: yaml

Enable the viewer
-----------------

The OpenAPI interactive viewer is disabled by default.
Exporting the ``OPENAPI`` environment variable when building
makes Sphinx copy the specification to the output directory
and add an ``openapi`` tag that we can use in the documentation source::

   export OPENAPI=1

Then rebuild the docs to pick up the specification::

   make clean html

.. tip::

   Unset the variable to go back to the default build.

Confirm the viewer works
------------------------

Serve the documentation locally::

   make run

Navigate to ``/how-to/openapi/``.
When the feature flag is enabled,
the page renders the Swagger UI for the shipped specification right here;
the snippet that does this should be included in your documentation source
with the ``.. raw:: html`` directive:

.. literalinclude:: assets/openapi._rst
   :language: html
   :lines: 2-

.. only:: openapi

   When added, the snippet above renders the interactive viewer:

   .. include:: assets/openapi._rst

.. only:: not openapi

   .. warning::

      The interactive viewer is hidden now because ``OPENAPI`` was not set
      when this documentation was built.
      Export ``OPENAPI=1`` when building the documentation to see it here.

Troubleshooting
---------------

* The ``make html`` command fails with `unknown tag`:
  Make sure you exported the environment variable
  in the same shell session that runs ``make``.

* The Swagger UI appears but cannot load the specification:
  Make sure that ``openapi.yaml`` exists in the *root* of your build output
  or adjust the import paths according to your build structure.
  Also, overriding the ``html_extra_path`` setting in ``conf.py``
  may interfere with this configuration
  because it is used to copy the specification to the output directory.
