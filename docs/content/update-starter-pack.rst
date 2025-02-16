.. _update-sp:

Update the starter pack
=======================

This section describes the ways to update the starter pack.
Several options exist.


With ``make update`` (recommended)
----------------------------------

This suits most scenarios.
Run ``make update`` to sync the latest updates from the starter pack repository::

  make update


This affects only what's listed in :file:`update.txt` in the starter pack repository;
all files there are expected to be an integral part of the starter pack
that can be overwritten without warning, so avoid customising them.
Instead, try to build new features on top of what the starter pack provides.

.. attention::

   If you do customise some of these files anyway (e.g. for historical reasons),
   add exceptions in your local :file:`update_exclude.txt` file.


With ``git merge``
------------------

This should be used only if you have many fine-grained differences
between your installation and the starter pack
that you want to cherry-pick.
You need to feel confident using git and doing merges.

Add the starter pack repository as a remote and fetch it::

  git remote add starter-pack https://github.com/canonical/sphinx-docs-starter-pack.git
  git fetch starter-pack


Next, merge the updates from the starter pack, resolving any arising conflicts::

  git merge --no-commit --no-ff --allow-unrelated-histories starter-pack/main



.. attention::

   The `--allow-unrelated-histories
   <https://git-scm.com/docs/git-merge#Documentation/git-merge.txt---allow-unrelated-histories>`_
   option can be tricky; proceed with caution.


Finally, commit the updates::

  git add .
  git commit -m "Synced latest updates from starter-pack/main"
