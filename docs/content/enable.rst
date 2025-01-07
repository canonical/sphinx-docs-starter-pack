.. _enable:

Copy the starter pack
=====================

Make sure to copy all required starter pack files to initialise a new documentation set:

#. Clone the `Starter pack <https://github.com/canonical/sphinx-docs-starter-pack>`_ repository to a temporary local folder
#. Copy the following folders and files from the starer pack temporary folder to the same paths in the repo you want your documentation to be:

   - :file:`.github/workflows/*-checks.yml` -- documentation tests
   - :file:`docs` -- your documentation folder. Original content includes initial documentation pages (you are reading one of them) and internal Sphinx files 
   - :file:`.readthedocs.yaml` -- the Readthedocs configuration file
   - :file:`.wokeignore` -- a list of exceptions for the non-inclusive language check

After copying starter pack files to your repository continue by configuring your documentation set via the :file:`docs/conf.py` config file. 
For more information on configuration pararmeters, see the :ref:`customise` page. 
