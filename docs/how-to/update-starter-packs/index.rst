.. meta::
   :description: Learn how to update your Sphinx starter pack with the latest features and improvements.

.. _update-starter-packs:

========================
Update your starter pack
========================

The starter pack is updated frequently. After you copy its code and it becomes the documentation system in your project, you must manually maintain it. 

There are special pathways to bring in the latest features and improvements from the starter pack repository.

Determine your current version
------------------------------

There are two versions of the starter pack that entail different update processes:

- the **new**, or **extension-based** starter pack
- the **legacy**, or **pre-extension** starter pack

New starter pack
^^^^^^^^^^^^^^^^^

If your :file:`conf.py` includes ``canonical-sphinx`` under the ``extensions`` list, you are using the new starter pack. 

To update a new starter pack project to the latest version, see:

- :ref:`update-new-starter-pack`

.. note::
   New starter pack releases use a semantic versioning scheme for minor and patch versions, which can be found in your project's :file:`.sphinx/version` file. 

Legacy starter pack
^^^^^^^^^^^^^^^^^^^^

If your :file:`conf.py` does _not_ include ``canonical-sphinx`` you are using the legacy starter pack. 

To update a legacy starter pack project to the latest version of the new starter pack:

- :ref:`update-legacy-starter-pack`

.. toctree::
   :hidden:

    New starter pack <new-starter-pack>
    Legacy starter pack <legacy-starter-pack>
