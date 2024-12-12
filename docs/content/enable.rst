.. _enable:

Enable the starter pack
=======================

You can use the starter pack to set up your documentation in one of the following ways:

- As a standalone documentation project in a new repository
- In a dedicated documentation folder in an existing code repository

The starter pack provides a shell script that updates and copies the starter pack files to the selected location.

.. note::
   The recommended way of setting up the starter pack is to use the initialisation script.
   This method is automatically tested for the two scenarios mentioned above.

   However, if you prefer to copy the files manually instead of running the script, this is also possible.
   Make sure to check the comments in the script in this case, because you will need to update the configuration in several files (in addition to copying the files to the correct locations).
   Also see :ref:`enable-behind-the-scenes`.


Run the initialisation script
-----------------------------

The initialisation script will download all required files, update them, and copy them to the selected location.

1. Download :file:`init.sh` from the starter pack repository.
#. Put the script into the root folder of the Git repository in which you want to enable the starter pack.

   This can be a new, empty repository or your code repository.
#. Make the script executable::

     chmod u+x init.sh
#. Run the script::

     ./init.sh
#. When prompted, enter the installation directory:

   - For standalone repositories, enter a full stop (``.``).
   - For documentation in code repositories, enter the name of the documentation folder (for example, ``docs``).

     If the folder does not yet exist, it is created.
     If the folder exists already, some of its files might be overwritten by starter pack files, so make sure you have a backup.
#. When prompted, specify if you'll be using ``.rst`` or ``.md``
#. Check the output for any warnings or errors.

You can now delete the :file:`init.sh` file.

.. _enable-behind-the-scenes:

Behind the scenes
-----------------

We recommend using the initialisation script to enable the starter pack.
Here's a summary of what it does:

1. Prompt for the directory that will contain the documentation.
#. Clone the starter pack repository into a temporary directory.
#. Update several of the configuration files to adapt paths to the documentation directory.
#. Create the documentation directory.
#. Copy the starter pack files into the documentation directory.
#. Move some required files into the root folder of the repository (the GitHub workflow file and a :file:`.wokeignore` file), unless they exist already.
#. Remove the temporary directory.
