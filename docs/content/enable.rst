.. _enable:

Copy the starter pack
=====================

Make sure to copy all required starter pack files to initialise a new documentation set:

#. Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a temporary local folder
#. Copy the following folders and files from the starer pack temporary folder to the same paths in the repository you want your documentation to be:

   - :file:`docs` -- your documentation folder. Original content includes initial documentation pages (you are reading one of them) and internal Sphinx files 
   - :file:`.readthedocs.yaml` -- the **Read the Docs** configuration file
   - :file:`.wokeignore` -- a list of exceptions for the non-inclusive language check
   - :file:`.github/workflows/*-checks.yml` -- documentation tests

After copying starter pack files to your repository continue by configuring your documentation set via the :file:`docs/conf.py` :spellexception:`config file`. 
For more information on configuration parameters, see the :ref:`customise` page. 
