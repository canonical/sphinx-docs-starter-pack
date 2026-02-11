.. meta::
    :description: Learn about what Starter Pack is made 

.. _explanation-components:

Starter pack components
#######################

Starter pack is template of a `Sphinx <https://www.sphinx-doc.org/en/master/>`_ project, it provides a layout of the project's file structure, a theme, and all the necessary dependencies.

Sphinx
======

`Sphinx <https://www.sphinx-doc.org/en/master/>`_  is the core documentation build engine that converts reStructuredText or Markdown files into HTML.

`docs/conf.py` is a configuration file that defines the properties of the Sphinx project such as project metadata and dependencies.
 
.. mermaid::
    :caption: Sphinx as build engine 

    graph TD
        Source@{ shape: doc, label: "Source files<br>.rst or .md"}
        Conf@{ shape: doc, label: "Project configuration file<br>docs/conf.py"}
        SphinxEng["Sphinx engine"]
        HTML@{ shape: doc, label: "HTML"}

        Source -- provides content to --> SphinxEng
        Conf -- provides settings to --> SphinxEng
        SphinxEng -- generates --> HTML

Python
======

Sphinx is a Python application and many of its extensions are Python applications. By extension, Starter pack depends on Python and Python package manager. As it is generally recommended to work on projects locally in a virtual environment, Starter pack's local build relies on Python ``venv``. 

To be able to work on a Starter pack-based project, you must have ``python3``, ``python3-venv``, and ``python3-pip`` on your system.

.. mermaid::
    :caption: Python's role in Starter Pack

    graph TD
        Python["Python<br>(python3, python3-venv, python3-pip)"]
        subgraph VEnv["Virtual environment"]
            SphinxEng["Sphinx engine"]
            Dependencies["Project dependencies"]
            HTML@{ shape: doc, label: "HTML"}
        end          

        Python -- creates --> VEnv
        Python -- installs --> Dependencies
        SphinxEng -- builds --> HTML
        SphinxEng -- relies on --> Dependencies

Extensions
==========

Sphinx's default functionality can always be changed and expanded with built-in or third-party extensions for tasks like creating diagrams, testing code, and more. 

Starter pack is preconfigured with a curated and tested set of extensions.

.. mermaid::
    :caption: Extention types

    graph TD
        Python["Python"]
            SphinxEng["Sphinx engine"]
            subgraph Dependencies["Project dependencies"]
                BuiltIn["Built-in Sphinx extensions"]
                ThirdParty["Third-party extensions"]
            end
        Conf@{ shape: doc, label: "docs/conf.py"}
        Req@{ shape: doc, label: "requirements.txt"}

        Python -- installs --> Req
        SphinxEng -- provides --> BuiltIn
        Req -- specifies --> ThirdParty
        Dependencies --  enabled in --> Conf
        
Built-in extensions
-------------------

Built-in extensions do not need to be installed separately from Sphinx and can be enabled directly through `docs/conf.py`.
`docs/conf.py` in the Starter Pack has already been configured to enabled typical extensions necessary for docmentation work.

.. _default-extensions:

The following extensions are enabled by default:

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

Third-party extensions
----------------------

If an extention is not built into Sphinx, you must download and install it into your environment before you can enable it in the Sphinx configuration. 

As many extensions are Python applications, Starter Pack uses a `requirements.txt <https://pip.pypa.io/en/stable/reference/requirements-file-format/>`_ file to manage them.  

.. mermaid::
    :caption: Third-party extensions

    graph TD
        subgraph ThirdParty["Third-party extensions"]
            MystExt["myst-parser"]
            CanExt["canonical-sphinx"]
            OtherExt["Other extensions"]
        end
        Conf@{ shape: doc, label: "docs/conf.py"}
        Req@{ shape: doc, label: "requirements.txt"}
        MystLogic["Markdown conversion"]
        Theme["Canonical branded theme"]
        OtherFunc["Various functionality"]
        Furo["Furo theme"]

        ThirdParty -- installed based on --> Req
        ThirdParty -- enabled in --> Conf
        MystLogic -- provided by --> MystExt 
        Theme -- packages as --> CanExt
        OtherFunc -- proovided by --> OtherExt 
        Furo -- serves as a base for --> Theme 

Markdown support
^^^^^^^^^^^^^^^^

By default, Sphinx uses reStructuredText. To be able to build Markdown, it relies on `MyST parser <https://myst-parser.readthedocs.io/en/latest/>`_ that requires a `myst-parser` extention.

Canonical theme
^^^^^^^^^^^^^^^

Canonical theme is based on the Furo theme and packaged as a standalone `canonical-sphinx <https://github.com/canonical/canonical-sphinx>`_ extention. It is based on an upstream Furo theme and is designed to follow Canonical branding.

Command line tools
==================

Starter Pack uses Make as its local build system. Starter Pack's Makefile is developed specifically to serve as an interface for operating the project, creating a virtual environment and installing dependencies with one command. 

Makefile
--------

Some of the commands that Makefile has are built to represent Sphinx-native functionality for building documentation or testing the URLs in a simplified form while also managing all the necessary dependencies, for example, instead of using `sphinx-build linkcheck SOURCEDIR OUTPUTDIR` command, you can use `make linkcheck`. 

See :ref:`explanation-build` to learn how the local build process works.  

Additionally, the Makefile provides commands to trigger third-party CLI tools, such as the Vale prose linter for :ref:`automatic-checks-styleguide`.

.. mermaid::
    :caption: Makefile build interface and its targets

    graph LR
       Makefile@{ shape: doc, label: "Makefile" }
       SphinxEng["Sphinx commands<br>(html, linkcheck)"]
       Dependencies["Project dependencies"]
       Vale["Language linter<br>(Vale)"]
       
       Makefile -- simplifies & invokes --> SphinxEng
       Makefile -- installs --> Dependencies
       Makefile -- triggers --> Vale

Read The Docs configuration file
================================

If you are publishing your documentation through Read the Docs, Read the Docs build logic is declared in ``.readthedocs.yaml``. Starter Pack comes with a pre-configured  ``.readthedocs.yaml`` with default values that should work for the majority of projects.

See :ref:`rtd` to learn how configure your Read the Docs instance.  

.. mermaid::
    :caption: RTD build configuration

    graph TD
        Python["python3, python3-venv, python3-pip"]
        SphinxEng["Sphinx engine"]
        RTD["Read the Docs (RTD)"]
        RTDConfig@{ shape: doc, label: "RTD configuration file<br>.readthedocs.yaml"}
        Conf@{ shape: doc, label: "docs/conf.py"}
        HTML@{ shape: doc, label: "HTML"}
            
        SphinxEng -- is declared in --> RTDConfig
        Conf -- is declared in --> RTDConfig
        Python -- is declared in --> RTDConfig
        RTDConfig -- defines the build logic for --> RTD
        RTD -- builds and hosts --> HTML


