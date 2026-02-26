.. _interactive-tables:

Add interactive data tables
===========================

The `Sphinx DataTables`_ extension enables interactive tables. Users can sort columns and filter rows. For examples, see the extension's documentation.

The extension isn't available by default in the starter pack. To read more about table functionality that is available out of the box, see :ref:`Tables (MyST) <myst_style_guide_tables>` and :ref:`Tables (reST) <style-guide-tables>`.

Include the ``sphinx-datatables`` extension
-------------------------------------------

To include the extension in your documentation, add ``sphinx-datatables`` to ``docs/requirements.txt``. 

Then, add ``sphinx_datatables`` to the ``extensions`` list in ``docs/conf.py``.

Make a table interactive by adding a special CSS class to the directive:

.. tab-set::

   .. tab-item:: reST

      .. code-block:: rst

         .. csv-table::
            :class: sphinx-datatable
            :file: /reuse/animals.csv
            :header-rows: 1

   .. tab-item:: MyST

      .. code-block:: none

         ```{csv-table}
         :class: sphinx-datatable
         :file: /reuse/animals.csv
         :header-rows: 1
         ```
