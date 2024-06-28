.. _enable:

Enable the starter pack
-----------------------

This section is for repository administrators. It shows how to initialise a
repository with the starter pack. Once this is done, documentation contributors
should follow section :ref:`work`.

**Note:** After setting up your repository with the starter pack, you need to track the changes made to it and manually update your repository with the required files.
The `change log <https://github.com/canonical/sphinx-docs-starter-pack/wiki/Change-log>`_ lists the most relevant (and of course all breaking) changes.
We're planning to provide the contents of this repository as an installable package in the future to make updates easier.

See the `Read the Docs at Canonical <https://library.canonical.com/documentation/read-the-docs>`_ and
`How to publish documentation on Read the Docs <https://library.canonical.com/documentation/publish-on-read-the-docs>`_ guides for
instructions on how to get started with Sphinx documentation.

Initialise your repository
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can either create a standalone documentation project based on this repository or include the files from this repository in a dedicated documentation folder in an existing code repository. The next two sections show the steps needed for each scenario.

See the `Automation`_ section if you would like to have this done via a shell script.

Standalone documentation repository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To add documentation to an existing code repository:

#. Create a directory called :file:`docs` at the root of the code repository.
#. Populate the above directory with the contents of the starter pack
   repository (with the exception of the :file:`.git` directory).
#. Copy the file(s) located in the :file:`docs/.github/workflows` directory into
   the :file:`.github/workflows` directory in the root of the code repository.
#. In the above workflow file(s), change the value of the
   :file:`working-directory` field from ``.`` to ``docs``.
#. Create a symbolic link to the :file:`docs/.wokeignore` file from the root
   directory of the code repository.
#. In the :file:`docs/.readthedocs.yaml` file, set the following:

   * ``post_checkout: cd docs && python3 .sphinx/build_requirements.py``
   * ``configuration: docs/conf.py``
   * ``requirements: docs/.sphinx/requirements.txt``

**Note:** When configuring RTD itself for your project, the setting \"Path for
``.readthedocs.yaml``\" (under **Advanced Settings**) will need to be given the
value of ``docs/.readthedocs.yaml``.

Automation
^^^^^^^^^^

To automate the initialisation for either scenario ensure you have the following:

- A GitHub repository where you want to host your documentation, cloned to your
  local machine. The recommended approach is to host the documentation alongside
  your code in a :file:`docs` folder. But a standalone documentation repository
  is also an option; in this case, start with an empty repository.
- Git and Bash installed on your system.

There is a provided :file:`init.sh` Bash script that does the following:

- Clones the starter pack GitHub repository.
- Creates the specified installation directory (if necessary).
- Updates working directory paths in workflow files, and updates configuration
  paths in the :file:`.readthedocs.yaml` file.
- Copies and moves contents and :file:`.github` files from the starter pack to
  the installation directory.
- Deletes the cloned repository when it\'s done.

To use the script:

#. Copy ``init.sh`` to your repository\'s root directory.
#. Run the script: ``./init.sh``.
#. Enter the installation directory when prompted. For standalone repositories,
   enter ``.``. For documentation alongside code, enter the folder where your
   documentation is (e.g. ``docs``).

When the script completes, review all changes before committing them.

Build the documentation
~~~~~~~~~~~~~~~~~~~~~~~

The documentation needs to be built before publication. This is explained
in more detail in section :ref:`local-checks` (for contributors), but at this time
you should verify a successful build. Run the following commands from where
your doc files were placed (repository root or the ``docs`` directory):

.. code-block:: none

   make install
   make html

Configure the documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must modify some of the default configuration to suit your project.
To simplify keeping your documentation in sync with the starter pack, all custom configuration is located in the ``custom_conf.py`` file.
You should never modify the common ``conf.py`` file.

Go through all settings in the ``Project information`` section of the ``custom_conf.py`` file and update them for your project.

See the following sections for further customisation.

Configure the header
^^^^^^^^^^^^^^^^^^^^

By default, the header contains your product tag, product name (taken from the ``project`` setting in the ``custom_conf.py`` file), a link to your product page, and a drop-down menu for "More resources" that contains links to Discourse and GitHub.

You can change any of those links or add further links to the "More resources" drop-down by editing the ``.sphinx/_templates/header.html`` file.
For example, you might want to add links to announcements, tutorials, getting started guides, or videos that are not part of the documentation.

Activate/deactivate feedback button
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The starter pack includes a set of extensions that are useful for all documentation sets.
They are pre-configured as needed, but you can customise their configuration in the  ``custom_conf.py`` file.

The following extensions are always included:

- |sphinx-design|_
- |sphinx_copybutton|_
- |sphinxcontrib.jquery|_

The following extensions will automatically be included based on the configuration in the ``custom_conf.py`` file:

- |sphinx_tabs.tabs|_
- |sphinx_reredirects|_
- |sphinxext.opengraph|_
- |lxd-sphinx-extensions|_ (``youtube-links``, ``related-links``, ``custom-rst-roles``, and ``terminal-output``)
- |myst_parser|_
- |notfound.extension|_

You can add further extensions in the ``custom_extensions`` variable in ``custom_conf.py``.
If the extensions need specific Python packages, add those to the ``custom_required_modules`` variable.

Add custom configuration
^^^^^^^^^^^^^^^^^^^^^^^^

To add custom configurations for your project, see the ``Additions to default configuration`` and ``Additional configuration`` sections in the ``custom_conf.py`` file.
These can be used to extend or override the common configuration, or to define additional configuration that is not covered by the common ``conf.py`` file.

The following links can help you with additional configuration:

- `Sphinx configuration`_
- `Sphinx extensions`_
- `Furo documentation`_ (Furo is the Sphinx theme we use as our base.)

Add Python packages
^^^^^^^^^^^^^^^^^^^

If you need additional Python packages for any custom processing you do in your documentation, add them to the ``custom_required_modules`` variable in ``custom_conf.py``.

If you use these packages inside of ``custom_conf.py``, you will encounter a circular dependency (see issue `#197`_).
To work around this problem, add a step that installs the packages to the ``.readthedocs.yaml`` file:

.. code-block:: yaml

  ...
  jobs:
    pre_install:
      - pip install <packages>
      - python3 .sphinx/build_requirements.py
      ...

In addition, override the ``ADDPREREQS`` variable in the Makefile with the names of the packages.
For example::

  make html ADDPREREQS='<packages>'


Add page-specific configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can override some global configuration for specific pages.

For example, you can configure whether to display Previous/Next buttons at the bottom of pages in the ``custom_conf.py`` file.
You can then override this default setting for a specific page (for example, to turn off the Previous/Next buttons by default, but display them in a multi-page tutorial).

To do so, add `file-wide metadata`_ at the top of a page.
See the following examples for how to enable Previous/Next buttons for one page:

reST
  .. code-block::

     :sequential_nav: both

     [Page contents]

MyST
  .. code-block::

     ---
     sequential_nav: both
     ---

     [Page contents]

Possible values for the ``sequential_nav`` field are ``none``, ``prev``, ``next``, and ``both``.
See the ``custom_conf.py`` file for more information.

Another example for page-specific configuration is the ``hide-toc`` field (provided by `Furo <Furo documentation_>`_), which can be used to hide the page-internal table of content.
See `Hiding Contents sidebar`_.

Change log
~~~~~~~~~~

See the `change log <https://github.com/canonical/sphinx-docs-starter-pack/wiki/Change-log>`_ for a list of relevant changes to the starter pack.
