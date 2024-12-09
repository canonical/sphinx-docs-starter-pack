.. _quickstart:

Quickstart guide
----------------

The following steps will guide you through setting up your documentation using the starter pack and building an initial set of documentation.

For more detailed information, see the other sections of the starter pack documentation.

1. Download the :file:`init.sh` file from the starter pack repository and place it into the directory where you want to set up your documentation.

#. Run the script and specify where you want the files for the documentation framework to be placed (either in the current directory or in a sub-directory).
   Your own documentation files will need to be placed in the same directory (or sub-directories of it) later.

   See :ref:`enable` for detailed information on what the script does.

#. Enter the documentation folder (the folder you specified when running the script) and build the documentation with the following command::

     make run

   This command creates a virtual environment, installs the Python dependencies, builds the documentation, and serves it on :literalref:`http://127.0.0.1:8000/`.

   See :ref:`build` for detailed information on different commands for building and viewing the documentation.

#. Keep this session running to rebuild the documentation automatically whenever a file is saved, and open :literalref:`http://127.0.0.1:8000/` in a web browser to see the locally built and hosted HTML.

#. To add a new page to the documentation, create a new document called :file:`reference.rst`, insert the following |RST|-formatted ``Reference`` heading, and then save the file:

   .. code-block:: rest

      Reference
      =========

   .. note::
      This Quickstart guide uses |RST|, but if you prefer to use Markdown, you can create a :file:`reference.md` file with the following content instead:

      .. code-block:: Markdown

         # Reference

#. Open :file:`index.rst`.

   At the bottom of this file, add a 3-space-indented line containing ``Reference <reference>`` to the end of the ``toctree`` section, and then save the file.
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

#. Check :literalref:`http://127.0.0.1:8000/`.

   The documentation will now show **Reference** added to the navigation, and selecting the link in the navigation will open the new ``reference.rst`` document.

See :ref:`guidance` for links to more detailed information about |RST| and Markdown/MyST.
