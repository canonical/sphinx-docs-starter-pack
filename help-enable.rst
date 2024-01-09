=======================
Enable the starter pack
=======================

This page is for repository administrators. It initialises a repository with
the starter pack. Once this is done, documentation contributors should follow
:doc:`help-usage`.

**Note:** After setting up your repository with the starter pack, you need to track the changes made to it and manually update your repository with the required files.
The `change log <https://github.com/canonical/sphinx-docs-starter-pack/wiki/Change-log>`_ lists the most relevant (and of course all breaking) changes.
We're planning to provide the contents of this repository as an installable package in the future to make updates easier.

See the `Read the Docs at Canonical <https://library.canonical.com/documentation/read-the-docs>`_ and
`How to publish documentation on Read the Docs <https://library.canonical.com/documentation/publish-on-read-the-docs>`_ guides for
instructions on how to get started with Sphinx documentation.

Two supported scenarios
-----------------------

You can either create a standalone documentation project based on this repository or include the files from this repository in a dedicated documentation folder in an existing code repository. The next two sections show the steps needed for each scenario. See `Setup script <https://canonical-starter-pack.readthedocs-hosted.com/setup-script/>`_ for an automated method (currently in beta).

Standalone documentation repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To create a standalone documentation repository, clone this starter pack
repository, `update the configuration <#configure-the-documentation>`_, and
then commit all files to the documentation repository.

You don't need to move any files, and you don't need to do any special
configuration on Read the Docs.

Here is one way to do this for newly-created fictional docs repository
``canonical/alpha-docs``:

.. code-block:: none

   git clone git@github.com:canonical/sphinx-docs-starter-pack alpha-docs
   cd alpha-docs
   rm -rf .git
   git init
   git branch -m main
   UPDATE THE CONFIGURATION AND BUILD THE DOCS
   git add -A
   git commit -m "Import sphinx-docs-starter-pack"
   git remote add upstream git@github.com:canonical/alpha-docs
   git push -f upstream main

Documentation in a code repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To add documentation to an existing code repository:

#. create a directory called ``docs`` at the root of the code repository
#. populate the above directory with the contents of the starter pack
   repository (with the exception of the ``.git`` directory)
#. copy the file(s) located in the ``docs/.github/workflows`` directory into
   the code repository's ``.github/workflows`` directory
#. in the above workflow file(s), change the value of the ``working-directory`` field from ``.`` to ``docs``
#. create a symbolic link to the ``docs/.wokeignore`` file from the root directory of the code repository
#. in file ``docs/.readthedocs.yaml`` set the following:

   * ``configuration: docs/conf.py``
   * ``requirements: docs/.sphinx/requirements.txt``

**Note:** When configuring RTD itself for your project, the setting "Path for
``.readthedocs.yaml``" (under **Advanced Settings**) will need to be given the
value of ``docs/.readthedocs.yaml``.

Build the documentation
-----------------------

The documentation needs to be built in order to be published. This is explained
in more detail in file :doc:`help-usage`, but at this time you should verify a
successful build. Run the following commands from where your doc files were
placed (repository root or the ``docs`` directory):

.. code-block:: none

   make install
   make html

Configure the documentation
---------------------------

You must modify some of the default configuration to suit your project.
To simplify keeping your documentation in sync with the starter pack, all custom configuration is located in the ``custom_conf.py`` file.
You should never modify the common ``conf.py`` file.

Go through all settings in the ``Project information`` section of the ``custom_conf.py`` file and update them for your project.

See the following sections for further customisation.

Configure the header
~~~~~~~~~~~~~~~~~~~~

By default, the header contains your product tag, product name (taken from the ``project`` setting in the ``custom_conf.py`` file), a link to your product page, and a drop-down menu for "More resources" that contains links to Discourse and GitHub.

You can change any of those links or add further links to the "More resources" drop-down by editing the ``.sphinx/_templates/header.html`` file.
For example, you might want to add links to announcements, tutorials, getting started guides, or videos that are not part of the documentation.

Activate/deactivate feedback button
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A feedback button is included by default, which appears at the top of each page
in the documentation. It redirects users to your GitHub issues page, and
populates an issue for them with details of the page they were on when they
clicked the button.

If your project does not use GitHub issues, set the ``github_issues`` variable
in the ``custom_conf.py`` file to an empty value to disable both the feedback button
and the issue link in the footer.
If you want to deactivate only the feedback button, but keep the link in the
footer, set ``disable_feedback_button`` in the ``custom_conf.py`` file to ``True``.

Configure included extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The starter pack includes a set of extensions that are useful for all documentation sets.
They are pre-configured as needed, but you can customise their configuration in the  ``custom_conf.py`` file.

The following extensions are always included:

- |sphinx-design|_
- |sphinx_tabs.tabs|_
- |sphinx_reredirects|_
- |lxd-sphinx-extensions|_ (``youtube-links``, ``related-links``, ``custom-rst-roles``, and ``terminal-output``)
- |sphinx_copybutton|_
- |sphinxext.opengraph|_
- |myst_parser|_
- |sphinxcontrib.jquery|_
- |notfound.extension|_

You can add further extensions in the ``custom_extensions`` variable in ``custom_conf.py``.

Add custom configuration
~~~~~~~~~~~~~~~~~~~~~~~~

To add custom configurations for your project, see the ``Additions to default configuration`` and ``Additional configuration`` sections in the ``custom_conf.py`` file.
These can be used to extend or override the common configuration, or to define additional configuration that is not covered by the common ``conf.py`` file.

The following links can help you with additional configuration:

- `Sphinx configuration`_
- `Sphinx extensions`_
- `Furo documentation`_ (Furo is the Sphinx theme we use as our base.)

Change log
----------

See the `change log <https://github.com/canonical/sphinx-docs-starter-pack/wiki/Change-log>`_ for a list of relevant changes to the starter pack.

.. LINKS

.. wokeignore:rule=master
.. _`Sphinx configuration`: https://www.sphinx-doc.org/en/master/usage/configuration.html
.. wokeignore:rule=master
.. _`Sphinx extensions`: https://www.sphinx-doc.org/en/master/usage/extensions/index.html
.. _`Furo documentation`: https://pradyunsg.me/furo/quickstart/

.. |sphinx-design| replace:: ``sphinx-design``
.. _sphinx-design: https://sphinx-design.readthedocs.io/en/latest/
.. |sphinx_tabs.tabs| replace:: ``sphinx_tabs.tabs``
.. _sphinx_tabs.tabs: https://sphinx-tabs.readthedocs.io/en/latest/
.. |sphinx_reredirects| replace:: ``sphinx_reredirects``
.. _sphinx_reredirects: https://documatt.gitlab.io/sphinx-reredirects/
.. |lxd-sphinx-extensions| replace:: ``lxd-sphinx-extensions``
.. _lxd-sphinx-extensions: https://github.com/canonical/lxd-sphinx-extensions#lxd-sphinx-extensions
.. |sphinx_copybutton| replace:: ``sphinx_copybutton``
.. _sphinx_copybutton: https://sphinx-copybutton.readthedocs.io/en/latest/
.. |sphinxext.opengraph| replace:: ``sphinxext.opengraph``
.. _sphinxext.opengraph: https://sphinxext-opengraph.readthedocs.io/en/latest/
.. |myst_parser| replace:: ``myst_parser``
.. _myst_parser: https://myst-parser.readthedocs.io/en/latest/
.. |sphinxcontrib.jquery| replace:: ``sphinxcontrib.jquery``
.. _sphinxcontrib.jquery: https://github.com/sphinx-contrib/jquery/
.. |notfound.extension| replace:: ``notfound.extension``
.. _notfound.extension: https://sphinx-notfound-page.readthedocs.io/en/latest/
