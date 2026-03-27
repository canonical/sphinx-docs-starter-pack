.. _skip-removed-urls-check:

Skip the removed URLs check
============================

The starter pack includes an automatic check that verifies no URLs are removed when you make changes to your documentation.
This helps prevent broken links when pages are removed without proper redirects.

However, in some cases you may want to intentionally skip this check, for example when:

* You are removing deprecated pages that are no longer relevant
* You are restructuring documentation and will add redirects in a follow-up commit
* You are working on a draft PR and will address URL changes later

How to skip the check
---------------------

To skip the removed URLs check, include the text ``skip removed-urls-check`` in one of the following places:

* The pull request title
* The pull request body/description
* A commit message

Example commit
--------------

Here's an example of a commit message that will skip the removed URLs check::

  Remove outdated installation guide

  The old installation instructions are no longer relevant
  after the new unified setup process was introduced.

  skip removed-urls-check

When you push this commit and create a pull request, the removed URLs check workflow will be skipped automatically.

.. note::
   Use this feature responsibly. Removing URLs without proper redirects can lead to broken links and a poor user experience.
   Make sure you have a valid reason to skip the check.
