.. _enable:

Copy the starter pack
=====================

Make sure to copy all required starter pack files to initialise a new documentation set:

#. Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a temporary local folder
#. Copy the following folders and files from the starter pack temporary folder to the repository where you want your documentation, placing them at the same relative paths:

   - :file:`docs` -- your documentation folder. Original content includes initial documentation pages (you are reading one of them) and internal Sphinx files 
   - :file:`.readthedocs.yaml` -- the **Read the Docs** configuration file
   - :file:`.wokeignore` -- a list of exceptions for the inclusive language check
   - :file:`.github/workflows/*-checks.yml` -- documentation tests

After copying the starter pack files to your repository, make sure to set the project's name and other configuration parameters in the :file:`docs/conf.py` :spellexception:`config file`.
For more information on configuration parameters, see the :ref:`customise` page. 
