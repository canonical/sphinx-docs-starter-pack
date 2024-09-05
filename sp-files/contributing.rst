.. TODO: Replace all mentions of ACME with your project name
.. TODO: Adjust all URLs (GitHub, etc.) accordingly
.. TODO: Adjust the guide as needed
.. TODO: Address all other TODOs below

How to contribute
=================

We believe that everyone has something valuable to contribute,
whether you're a coder, a writer or a tester.
Here's how and why you can get involved:

- **Why join us?** Work with like-minded people, develop your skills,
  connect with diverse professionals, and make a difference.

- **What do you get?** Personal growth, recognition for your contributions,
  early access to new features and the joy of seeing your work appreciated.

- **Start early, start easy**: Dive into code contributions,
  improve documentation, or be among the first testers.
  Your presence matters,
  regardless of experience or the size of your contribution.


The guidelines below will help keep your contributions effective and meaningful.


Code of conduct
---------------

When contributing, you must abide by the
`Ubuntu Code of Conduct <https://ubuntu.com/community/ethos/code-of-conduct>`_.


Licence and copyright
---------------------

By default, all contributions to ACME are made under the AGPLv3 licence.
See the `licence <https://github.com/canonical/acme/blob/main/COPYING>`_
in the ACME GitHub repository for details.

All contributors must sign the `Canonical contributor licence agreement
<https://ubuntu.com/legal/contributors>`_,
which grants Canonical permission to use the contributions.
The author of a change remains the copyright owner of their code
(no copyright assignment occurs).


Pull requests
-------------

Submit your changes as pull requests on `GitHub
<https://github.com/canonical/acme>`_.
Before you open a pull request,
ensure that the build occurs without any warnings or errors;
this includes documentation and tests.

Your changes will be reviewed in due time;
if approved, they will be eventually merged.


PR description
~~~~~~~~~~~~~~

.. TODO: Update with your template checklist details or drop if excessive

- **Title**: Summarise the change in a short, descriptive title.

- **Description**: Provide an explanation of the problem your PR addresses.
  Highlight any new features, bug fixes or refactoring.

- **Relevant issues**: Reference any
  `related issues, PRs and repos <https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls>`_.

- **Testing**: Explain whether new or updated tests are included.

- **Reversibility**: If you propose decisions that may be costly to reverse,
  outline the reasons and provide the steps to reverse if necessary.


Commits
~~~~~~~

Use separate commits for each logical change,
and for changes to different components.
Prefix your commits with the component they affect,
using the code tree structure,
e.g. prefix a commit that updates the ACME service with ``acme/service:``.

Use `conventional commits <https://www.conventionalcommits.org/>`_
for your commit messages to ensure consistency across the project:

.. code-block:: none

   Ensure correct permissions and ownership for the content mounts
    
    * Work around an ACME issue regarding empty dirs:
      https://github.com/canonical/acme/issues/12345
    
    * Ensure the source directory is owned by the user running a container.

   Links:
   - ...
   - ...


Such structure makes it easier to review contributions
and simplifies porting fixes to other branches.


Developer certificate of origin
-------------------------------

.. TODO: Update with your details or drop if excessive

To improve contribution tracking,
we use the `DCO 1.1 <https://developercertificate.org/>`_
and require a "sign-off" for any changes going into each branch.

The sign-off is a simple line at the end of the commit message
certifying that you wrote it
or have the right to commit it as an open-source contribution.

To sign off on a commit, use the ``--signoff`` option in ``git commit``.


Code
----

.. TODO: Update with your details; these are reasonable defaults

The formatting rules for ACME are enforced automatically using
`flake8 <https://flake8.pycqa.org/en/latest/>`_
and `Black <https://black.readthedocs.io/en/stable/>`_.

To run the checks locally before submitting your changes:

.. code-block:: console

   make format


Code structure
~~~~~~~~~~~~~~

- **Check linked code elements**:
  Check that coupled code elements, files and directories are adjacent.
  For instance, store test data close to the corresponding test code.

- **Group variable declaration and initialisation**:
  Declare and initialise variables together
  to improve code organisation and readability.

- **Split large expressions**:
  Break down large expressions
  into smaller self-explanatory parts.
  Use multiple variables where appropriate
  to make the code more understandable
  and choose names that reflect their purpose.

- **Use blank lines for logical separation**:
  Insert a blank line between two logically separate sections of code.
  This improves its structure and makes it easier to understand.


Coding standards
~~~~~~~~~~~~~~~~

- **Avoid nested conditions**:
  Avoid nesting conditions to improve readability and maintainability.

- **Remove dead code and redundant comments**:
  Drop unused or obsolete code and comments.
  This promotes a cleaner code base and reduces confusion.

- **Normalise symmetries**:
  Treat identical operations consistently, using a uniform approach.
  This also improves consistency and readability.


Tests
-----

All code contributions must include tests.

To run the tests locally before submitting your changes:

.. TODO: Update with your details

.. code-block:: console

    make test


Documentation
-------------

ACME's documentation is stored in the ``DOCDIR`` directory of the repository.
It is based on the `Canonical starter pack
<https://canonical-starter-pack.readthedocs-hosted.com/latest/>`_
and hosted on `Read the Docs <https://about.readthedocs.com/>`_.

For general guidance,
refer to the `starter pack guide
<https://canonical-starter-pack.readthedocs-hosted.com/latest/readme/>`_.

For syntax help and guidelines,
refer to the `Canonical style guides
<https://canonical-documentation-with-sphinx-and-readthedocscom.readthedocs-hosted.com/#style-guides>`_.

In structuring,
the documentation employs the `Diátaxis <https://diataxis.fr/>`_ approach.

To run the documentation locally before submitting your changes:

.. code-block:: console

   make run


Automatic checks
~~~~~~~~~~~~~~~~

GitHub runs automatic checks on the documentation
to verify spelling, validate links and suggest inclusive language.

You can (and should) run the same checks locally:

.. code-block:: console

   make spelling
   make linkcheck
   make woke
