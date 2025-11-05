.. _customise:

Customise the setup
===================

.. important::

   After setting up your repository with the starter pack, you should track the changes made to the starter pack.

   Changes to the look and feel, as well as common functionality, will be automatically available through updates to the `Canonical Sphinx`_ extension.

   Changes to files that are part of the starter pack, for example, :ref:`automatic-checks`, might require you to manually update your repository with the required files.
   See the starter pack's `change log`_ for the most relevant (and of course all breaking) changes.

Configuration for a starter pack based documentation is set in the :file:`docs/conf.py` Sphinx configuration file.

The starter pack's default configuration is prepared in a way that makes sense for most projects.
However, you must set some critical parameters that are unique for your project, like the project's name.

In addition, you can find some optional parameters or add your own configuration parameters to the file.

Required customisation
----------------------

You must check and update some of the parameters specific to your project.
Mandatory parameters are commented with the `TODO` keyword.

The following are some highlights of the available configuration parameters.

Update the project information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`docs/conf.py` file and update the configuration in the ``Project information`` section.
See the comments in the file for more information about each setting.

Open Graph configuration
^^^^^^^^^^^^^^^^^^^^^^^^

When you post a link to your documentation somewhere (for example, on Mattermost or Discourse), it might be shown with a preview.
This preview is configured through the Open Graph Protocol (:spellexception:`OGP`) configuration.

If you don't know yet where your documentation will be hosted, you can leave the URL empty.
If you do, specify the hosting URL.
You can leave the defaults for the website name and the preview image or specify your own.

Optional customisation
----------------------

The starter pack contains several features that you can configure, or turn off if they aren't suitable for your documentation.

Modify the template
~~~~~~~~~~~~~~~~~~~

The default starter pack templates provide an initial configuration for your documentation set, including:

- Header template - The top section of the page that contains your product's tag image and name, a link to your product's page (if available), and a drop-down menu for "More resources".
- Footer template - The bottom section of the page that contains sequential navigation controls, copyright information, licensing details, and other relevant links.

These project settings are configured in :file:`docs/conf.py` and are generally sufficient for most cases.
However, if you have additional requirements -- such as adding links to announcements or videos that are not part of the documentation -- you can override the default templates to customize them as needed.

See the :ref:`custom-templates` guide for details on how to do so.

Deactivate the feedback button
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the starter pack includes a feedback button at the top of each page.
This button redirects users to your GitHub issues page, and populates an issue for them with details of the page they were on when they clicked the button.

If your project does not use GitHub issues, set the ``github_issues`` variable in the :file:`docs/conf.py` file to an empty value to disable both the feedback button and the issue link in the footer.

If you want to deactivate the feedback button, but keep the link in the footer, set ``disable_feedback_button`` in the :file:`docs/conf.py` file to ``True``.

Configure the contributor display
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the starter pack will display a list of contributors at the bottom of each page.
This requires the GitHub URL and folder to be configured.

If you want to turn this contributor listing off, you can do so by setting the ``display_contributors`` variable in the :file:`docs/conf.py` file to ``False``.

To configure that only recent contributors are displayed, you can set the ``display_contributors_since`` variable.
It takes any Linux date format (for example, a full date, or an expression like "3 months").

Add redirects
~~~~~~~~~~~~~

If you rename a source file, its URL will change.
To prevent broken links, you should add a redirect from the old URL to the new URL in this case.

You can add redirects in the ``redirects`` variable in the :file:`docs/conf.py` file.

Configure included extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The starter pack includes a set of extensions that are useful for all documentation sets.
They are pre-configured as needed, but you can customise their configuration in the  :file:`docs/conf.py` file.

The following extensions are included by default:

* ``canonical_sphinx``
* ``notfound.extension``
* ``sphinx.ext.intersphinx``
* ``sphinx_config_options``
* ``sphinx_contributor_listing``
* ``sphinx_copybutton``
* ``sphinx_design``
* ``sphinx_filtered_toctree``
* ``sphinx_last_updated_by_git``
* ``sphinx_related_links``
* ``sphinx_reredirects``
* ``sphinx_roles``
* ``sphinx_sitemap``
* ``sphinx_tabs.tabs``
* ``sphinx_terminal``
* ``sphinx_ubuntu_images``
* ``sphinx_youtube_links``
* ``sphinxcontrib.cairosvgconverter``
* ``sphinxcontrib.jquery``
* ``sphinxext.opengraph``

The ``canonical_sphinx`` extension is required for the starter pack and provides the Furo-based theme and custom templates.

To add new extensions needed for your documentation set, add them to the ``extensions`` parameter in :file:`docs/conf.py`.

.. note::

   If any additional extensions need specific Python packages, ensure they are installed alongside the other requirements by adding them to the :file:`docs/requirements.txt` file.

Add page-specific configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can override some global configuration for specific pages.

For example, you can configure whether to display Previous/Next buttons at the bottom of pages by setting the ``sequential_nav`` variable in the :file:`docs/conf.py` file.

.. code:: python

   html_context = {
       ...
       "sequential_nav": "both"
   }

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
See the :file:`docs/conf.py` file for more information.

Another example for page-specific configuration is the ``hide-toc`` field (provided by `Furo <Furo documentation_>`_), which can be used to hide the page-internal table of content.
See `Hiding Contents sidebar`_.

Add your own configuration
--------------------------

Custom configuration parameters for your project can be used to extend or override the common configuration, or to define additional configuration that is not covered by the common ``conf.py`` file.

The following links can help you with additional configuration:

- `Sphinx configuration`_
- `Sphinx extensions`_
- `Furo documentation`_ (Furo is the Sphinx theme we use as our base)

If you need additional Python packages for any custom processing you do in your documentation, add them to the :file:`docs/requirements.txt` file.

Disable failure on warning
--------------------------

The docs build (``make html``) is, by default, set to fail when a warning (``WARNING`` in the build log) is encountered. To disable this setting, remove the ``--failure-on-warning`` option from the command specified in the ``html`` target in the ``Makefile``.

