.. _makefile:

Integrate the Makefiles
=======================

The starter pack contains two Makefiles, located in the documentation folder: :file:`Makefile` and :file:`Makefile.sp`.

:file:`Makefile.sp` implements the targets provided by the starter pack.
You should keep it up to date with recent changes to the starter pack; therefore, avoid making updates to this file.
(If you need updates, consider contributing them to the starter pack!)

You can use :file:`Makefile` to add custom targets or different target names.

Your project might contain a main Makefile in its root folder (usually the parent of the documentation folder), used for building the project rather than the documentation. If you want to integrate the starter pack targets into your project's main Makefile, you can use a command similar to the following::

  doc-%:
  	cd docs && $(MAKE) -f Makefile.sp sp-$* ALLFILES='*.md **/*.md'

This example will create targets prefixed with ``doc-`` (for example, ``doc-html`` and ``doc-serve``).
When calling :command:`make` with one of these targets from the project's root folder, they switch to the documentation folder (``docs`` in this case) and run the corresponding ``sp-*`` targets from :file:`Makefile.sp`.

In addition, the ``ALLFILES`` variable is overridden with a different set of files, which is needed for the :ref:`automatic-checks-inclusivelanguage`.
