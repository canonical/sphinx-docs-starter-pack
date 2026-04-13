.. meta::
   :description: Configure references to external Sphinx projects with the Intersphinx extension.

.. _how-to-link-docs-intersphinx:

Link to other documentation sets with Intersphinx
=================================================

This guide provides instructions on how to set up external references using the Intersphinx extension. 
Linking to external Sphinx-based documentation sets via hyperlinks is difficult to maintain. 
Intersphinx provides a more robust alternative, linking to sections of other Sphinx projects based on 
labels mapped out in an inventory list as ``objects.inv``. To effectively use Intersphinx, sections in 
the target documentation set must have labels.

Configure the extension
-----------------------

In the ``conf.py`` file in your docs directory, add or enable ``sphinx.ext.intersphinx`` under ``extensions``:

.. code-block:: python
   :caption: conf.py

   extensions = [
       ...
       "sphinx.ext.intersphinx",
       ]

Then, connect to the other project in the ``intersphinx_mapping``
setting:

.. code-block:: python
   :caption: conf.py

   # Add configuration for intersphinx mapping
   # Map only the Sphinx documentation sets that you need to link to from your docs set.
   intersphinx_mapping = {
       'project-key': ('https://example.com', None)
   }

Replace ``project-key`` with the internal identifier for the project that you'll specify
in the document markup. For example, if the identifier were ``chisel``, an Intersphinx link to it would be ``:external+chisel:ref:`target```.

The value after the URI points to a custom path location. If a project stores its ``objects.inv`` at a special location, replace ``None`` with the path to it.

Check the external target labels
--------------------------------

To check external target page labels, either search the project source code 
manually or inspect the ``objects.inv`` file. In this file, each section has a 
unique label.

To inspect the file manually, run:

.. code-block:: bash

    source .sphinx/venv/bin/activate
    python -m sphinx.ext.intersphinx https://example.com/objects.inv

The output lists the different pages and their labels: 

.. terminal::
    :output-only:

    lrd:doc
        explanation/faq                          FAQ                                     : explanation/faq/
        explanation/index                        Explanation                             : explanation/
        explanation/mode-of-operation            How Chisel works                        : explanation/mode-of-operation/
    lrd:label
        chise_faq                                FAQ                                     : explanation/faq/#chise-faq
        chisel-releases_ref                      chisel-releases                         : reference/chisel-releases/#chisel-releases-ref
        chisel_helloworld_tutorial               Getting started with Chisel             : tutorial/getting-started/#chisel-helloworld-tutorial
    std:doc
        explanation/faq                          FAQ                                     : explanation/faq/
        explanation/index                        Explanation                             : explanation/
        explanation/mode-of-operation            How Chisel works                        : explanation/mode-of-operation/
    std:label
        chise_faq                                FAQ                                     : explanation/faq/#chise-faq
        chisel-releases_ref                      chisel-releases                         : reference/chisel-releases/#chisel-releases-ref
        chisel_helloworld_tutorial               Getting started with Chisel             : tutorial/getting-started/#chisel-helloworld-tutorial

The appropriate labels are under ``std:label``.

Add references to the text
--------------------------

To add in-line references, follow this structure:

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Format
     - Syntax
   * - reST
     - ``:external+project_key:ref:`an_external_target```
   * - MyST
     - ``{ref}`project_key:an_external_target```
