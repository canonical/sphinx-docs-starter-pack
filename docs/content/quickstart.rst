.. _quickstart:

Quickstart guide
-----------------

This guide is about the starter pack setup and usage.

Initial setup
*************

The following steps will guide you through setting up your documentation:

#. Clone the [Starter pack](https://github.com/canonical/sphinx-docs-starter-pack) repository to a local folder.
#. Copy the following files to the same folders in the repo you want your documentation to be:
   - `.github/workflows/*-checks.yml` -- documentation tests
   - `docs` -- documentation content and sphinx files
   - `.readthedocs.yaml` -- Readthedocs configuration file
   - `.wokeignore` -- exceptions list for the non-inclusive language check
#. Configure your new documentation set by adjusting the copied `docs/conf.py` config file. Make sure to pay attention to all `TODO` comments. 

Build
*****

To build the documentation, use the following command:

   .. code-block:: none

      make run

This command creates a virtual environment, installs the Python dependencies, builds the documentation, and serves it on the :literalref:`http://127.0.0.1:8000/` address.

See the :ref:`build` page for more information on different commands for building and viewing the documentation.

Work on content
***************

Keep the session with the `make run` command running to rebuild the documentation automatically whenever a file in the `docs/content` is saved, and open the :literalref:`http://127.0.0.1:8000/` address in a web browser to see the locally built and hosted documentation as HTML.

To add a new page to the documentation:    

   #. Create a new file. For example, to create the `Reference` page, create a document called :file:`reference.rst`, insert the following |RST|-formatted heading ``Reference`` at the beginning, and then save the file:

   .. code-block:: rest
      :caption: reStructuredText example

         The output of this line starts with four spaces.

   If you prefer to use Markdown syntax instead of |RST|, you can create a Markdown file instead. For example, :file:`reference.md` file with the following Markdown-formatted heading:

   .. code-block:: markdown
      :caption: Markdown example
      
         # Reference
  
   #. Open the :file:`index.rst`. At the bottom of this file, add a 3-space-indented line containing ``Reference <reference>`` to the end of the ``toctree`` section, and then save the file.

   This is the navigation title for the new document and its filename without the extension.

   The ``toctree`` section will now look like this:

   .. code-block:: rest

      .. toctree::
         :hidden:
         :maxdepth: 2

         self
         Reference <reference>

   .. note::
      You can leave out the navigation title to use the document title instead.
      This means that in this example, you could also just type ``reference`` instead of ``Reference <reference>``.

#. Check the rendered documentation at the :literalref:`http://127.0.0.1:8000/` address in a web browser.

   The documentation will now show the **Reference** page added to the navigation.

See :ref:`guidance` for links to more detailed information about the |RST| and Markdown/MyST syntax.
