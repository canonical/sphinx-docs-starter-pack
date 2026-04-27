.. meta::
   :description: Learn how to update your Sphinx Starter Pack with the latest features and improvements.

.. _update-starter-packs:

========================
Update your Starter Pack
========================

The Starter Pack is updated frequently. After you copy its code and it becomes the documentation system in your project, you must manually maintain it. 

There are special pathways to bring in the latest features and improvements from the Starter Pack repository.

Determine your current version
------------------------------

There are two versions of the Starter Pack that entail different update processes:

- the **new**, or **extension-based** Starter Pack
- the **legacy**, or **pre-extension** Starter Pack

New Starter Pack
^^^^^^^^^^^^^^^^^

If your :file:`conf.py` includes ``canonical-sphinx`` under the ``extensions`` list, you are using the new Starter Pack. 

To update a new Starter Pack project to the latest version, see:

- :ref:`update-new-starter-pack`

.. note::
   New Starter Pack releases use a semantic versioning scheme for minor and patch versions, which can be found in your project's :file:`.sphinx/version` file. 

Legacy Starter Pack
^^^^^^^^^^^^^^^^^^^^

If your :file:`conf.py` does _not_ include ``canonical-sphinx`` you are using the legacy Starter Pack. 

To update a legacy Starter Pack project to the latest version of the new Starter Pack:

- :ref:`update-legacy-starter-pack`

.. toctree::
   :hidden:

    New Starter Pack <new-starter-pack>
    Legacy Starter Pack <legacy-starter-pack>
