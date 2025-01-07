.. _edit:

Edit content
============

The landing page is stored in the :file:`docs/index.rst` file 
while the rest of the pages are stored in the :file:`docs/content/` folder.

The navigation menu structure is set by the `.. toctree::` blocks used to list all nested pages for a page. 
The :file:`index.rst` page's toctree contains the top level navigation menu.

To add a new page to the documentation:    

1. Create a new file in the `docs/content` folder. For example, to create the `Reference` page, create a document called :file:`reference.rst`, insert the following |RST|-formatted heading ``Reference`` at the beginning, and then save the file:

   .. code-block:: rest
      :caption: reStructuredText title example

         Reference
         =========

   If you prefer to use Markdown (MyST) syntax instead of |RST|, you can create a Markdown file. For example, :file:`reference.md` file with the following Markdown-formatted heading at the beginning:

   .. code-block:: markdown
      :caption: Markdown title example
         
         # Reference

2. Add the new file to the navigation menu. Open the :file:`index.rst` file or another page that you want to add a nested page to. At the bottom of the file locate the ``toctree`` block and add a properly indented line containing the path (without a file extension) to the new file created in the first step. For example, ``content/reference``.

   The ``toctree`` block will now look like this:

   .. code-block:: rest
      :caption: Toctree block example 
         
         .. toctree::
         :hidden:
         :maxdepth: 2
         /content/quickstart
         /content/setup
         /content/update
         /content/automatic_checks
         /content/examples
         /content/contributing
         /content/reference

    
The documentation will now show the new page added to the navigation.

By default, the page's title (the first heading in the file) is used for the navigation menu entry. You can overwrite a name of a Nav Menu element by specifying it explicitly in the toctree block, for example: `Reference </content/reference>`.
