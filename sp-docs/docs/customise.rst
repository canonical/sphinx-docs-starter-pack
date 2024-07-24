.. _customise:

Customise the setup
===================

The starter pack is configured in a way that makes sense for most projects.
However, you must customise some settings for your project, like the project name.

In addition, there are some settings that you can customise if you wish so.
And of course, you can add your own configuration as well.

Required customisation
----------------------

You must check and update some of the configuration to adapt the documentation to your project.

Update the project information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`conf.py` file and update the configuration in the ``Project information`` section.
See the comments in the file for more information about each setting.

You can adapt settings in the rest of the file as well, but this isn't required.

Open Graph configuration
^^^^^^^^^^^^^^^^^^^^^^^^

When you post a link to your documentation somewhere (for example, on Mattermost or Discourse), it might be shown with a preview.
This preview is configured through `Open Graph`_.

If you don't know yet where your documentation will be hosted, you can leave the URL empty.
If you do, specify the hosting URL.
You can leave the defaults for the website name and the preview image or specify your own.

Configure the header
~~~~~~~~~~~~~~~~~~~~

By default, the header contains your product tag, product name (taken from the ``project`` setting in the :file:`conf.py` file), a link to your product page, and a drop-down menu for "More resources".

In many cases, this default setup is sufficient, but you should always check it.

You can change any of those links or add further links to the "More resources" drop-down by editing the :file:`.sphinx/_templates/header.html` file.
For example, you might want to add links to announcements, tutorials, getting started guides, or videos that are not part of the documentation.

Optional customisation
----------------------

The starter pack contains several features that you can configure, or turn off if they aren't suitable for your documentation.

Deactivate the feedback button
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the starter pack includes a feedback button at the top of each page in the documentation.
This button redirects users to your GitHub issues page, and populates an issue for them with details of the page they were on when they clicked the button.

If your project does not use GitHub issues, set the ``github_issues`` variable in the :file:`conf.py` file to an empty value to disable both the feedback button and the issue link in the footer.
If you want to deactivate only the feedback button, but keep the link in the footer, set ``disable_feedback_button`` in the :file:`conf.py` file to ``True``.

Configure the contributor display
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the starter pack will display a list of contributors at the bottom of each page.
This requires the GitHub URL and folder to be configured.

If you want to turn this contributor listing off, you can do so by setting the ``display_contributors`` variable in the :file:`conf.py` file to ``False``.

To configure that only recent contributors are displayed, you can set the ``display_contributors_since`` variable.
It takes any Linux date format (for example, a full date, or an expression like "3 months").

Add redirects
~~~~~~~~~~~~~

If you rename a source file, its URL will change.
To prevent broken links, you should add a redirect from the old URL to the new URL in this case.

You can add redirects in the ``redirects`` variable in the :file:`conf.py` file.

Configure included extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The starter pack includes a set of extensions that are useful for all documentation sets.
They are pre-configured as needed, but you can customise their configuration in the  :file:`conf.py` file.

The following extensions are always included:

- :literalref:`sphinx-design <https://sphinx-design.readthedocs.io/en/latest/>`
- :literalref:`sphinx_copybutton <https://sphinx-copybutton.readthedocs.io/en/latest/>`
- :literalref:`sphinxcontrib.jquery <https://github.com/sphinx-contrib/jquery/>`

The following extensions are included unless they are disabled when loading the extension:

- :literalref:`sphinx_tabs.tabs <https://sphinx-tabs.readthedocs.io/en/latest/>`
- :literalref:`sphinx_reredirects <https://documatt.gitlab.io/sphinx-reredirects/>`
- :literalref:`sphinxext.opengraph <https://sphinxext-opengraph.readthedocs.io/en/latest/>`
- :literalref:`canonical-sphinx-extensions <https://github.com/canonical/canonical-sphinx-extensions>` (``youtube-links``, ``related-links``, ``custom-rst-roles``, and ``terminal-output``)
- :literalref:`myst_parser <https://myst-parser.readthedocs.io/en/latest/>`
- :literalref:`notfound.extension <https://sphinx-notfound-page.readthedocs.io/en/latest/>`

You can add further extensions in the ``extensions`` variable in :file:`conf.py`.
If the extensions need specific Python packages, add those to the :file:`requirements.py` file.

Add page-specific configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can override some global configuration for specific pages.

For example, you can configure whether to display Previous/Next buttons at the bottom of pages by setting the ``sequential_nav`` variable in the :file:`conf.py` file.
You can then override this default setting for a specific page (for example, to turn off the Previous/Next buttons by default, but display them in a multi-page tutorial).

To do so, add `file-wide metadata`_ at the top of a page.
See the following examples for how to enable Previous/Next buttons for one page:

|RST|::

   :sequential_nav: both

   [Page contents]

MyST::

   ---
   sequential_nav: both
   ---

   [Page contents]

Possible values for the ``sequential_nav`` field are ``none``, ``prev``, ``next``, and ``both``.
See the :file:`conf.py` file for more information.

Another example for page-specific configuration is the ``hide-toc`` field (provided by `Furo <Furo documentation_>`_), which can be used to hide the page-internal table of content.
See `Hiding Contents sidebar`_.

Add your own configuration
--------------------------

To add custom configuration for your project, see the ``Additions to default configuration`` and ``Additional configuration`` sections in the :file:`conf.py` file.
These can be used to extend or override the common configuration, or to define additional configuration that is not covered by the common ``conf.py`` file.

The following links can help you with additional configuration:

- `Sphinx configuration`_
- `Sphinx extensions`_
- `Furo documentation`_ (Furo is the Sphinx theme we use as our base)

If you need additional Python packages for any custom processing you do in your documentation, add them to the :file:`.sphinx/requirements.txt` file.
