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


This does not affect the files that you may have customised in your project::

  content/*
  reuse/*
  .custom_wordlist.txt
  conf.py
  index.rst


Any updates to these files done in the upstream version of the starter pack
must be added manually.


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
