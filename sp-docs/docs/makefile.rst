.. _makefile:

Integrate the Makefiles
=======================

The starter pack contains two Makefiles: :file:`Makefile` and :file:`Makefile.sp`.

:file:`Makefile.sp` implements the targets provided by the starter pack.
You should keep it up-to-date with recent changes to the starter pack; therefore, avoid doing updates to the file.
(If you need updates, consider contributing them to the starter pack!)

You can use :file:`Makefile` to add custom targets or different target names.

If you want to integrate the starter pack targets into the main Makefile of your project, you can do so with a command similar to the following::

  doc-%:
  	cd docs && $(MAKE) -f Makefile.sp sp-$* ALLFILES='*.md **/*.md'

This example will create targets prefixed with ``doc-`` (for example, ``doc-html`` and ``doc-serve``).
When calling these targets, they switch to the documentation folder (``docs`` in this case) and run the corresponding ``sp-*`` targets from :file:`Makefile.sp`.
In addition, the ``ALLFILES`` variable is overridden with a different set of files (this is needed for the :ref:`automatic-checks-inclusivelanguage`).
