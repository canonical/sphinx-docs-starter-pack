.. _how-to-add-documentation-testing:

Test commands in documentation
==============================

It's challenging to keep documentation in sync with products as they evolve. This
process is aided by *Spread*, a test distribution that can work through your
documentation and report failures in GitHub workflows.

Creating a Spread test for your documentation is **not** required to use
the Sphinx starter pack; this is an optional capability.

What you'll need
----------------

* `Multipass <https://documentation.ubuntu.com/multipass/latest/how-to-guides/install-multipass/>`_ installed on your machine 
* `Spread <https://github.com/canonical/spread>`_ installed on your machine

.. warning::

    Spread requires elevated permissions to run as root. Use the Go install method
    recommended in the Spread README to install Spread.

Create the Spread test materials
--------------------------------

Create a dedicated directory to hold the materials for your
Spread tests, for example, ``tests``. 

Under the ``tests`` directory, create dedicated directories
to store the files for your documentation Spread tests. For individual tests,
you will need a ``task.yaml`` file that contains all the commands
you want the Spread test to run.

An example ``task.yaml`` file is shown below:

.. code-block:: yaml
    :caption: task.yaml

    ###########################################
    # IMPORTANT
    # Comments matter!
    # The docs use the wrapping comments as
    # markers for including said instructions
    # as snippets in the docs.
    ###########################################
    summary: Example Spread test

    kill-timeout: 5m

    execute: |
      # [docs:first-wrapping-command]
      echo "This is the first command that Spread will run"
      # [docs:first-wrapping-command-end] 

      # [docs:second-wrapping-command]
      echo "This is the second command that Spread will run"
      # [docs:second-wrapping-command-end] 

The ``summary`` section contains a brief description of the documentation you're testing, and
the ``execute`` section contains your documentation's commands.
The ``kill-timeout`` option has a default of 10 minutes and doesn't need to be
included if your test will complete in that time frame. 

By wrapping commands with comments using the syntax
``# [docs:example-wrapping-command]`` and ``# [docs-example-wrapping-command-end]``,
you can include the exact commands from ``task.yaml`` in the tutorial file like so:

.. tab-set::

   .. tab-item:: reStructuredText
      :sync: rest-commands

      .. code-block:: rst
        :caption: Example block to include commands from ``task.yaml``

        .. literalinclude:: relative-path-to/task.yaml
            :language: bash
            :start-after: [docs:first-wrapping-command]
            :end-before: [docs:first-wrapping-command-end]
            :dedent: 2

   .. tab-item:: MyST
      :sync: myst-commands

      .. code-block:: md
        :caption: Example block to include commands from ``task.yaml``

        ```{literalinclude} relative-path-to/task.yaml
        :language: bash
        :start-after: [docs:first-wrapping-command]
        :end-before: [docs:first-wrapping-command-end]
        :dedent: 2
        ```

Create a Spread test
--------------------

From the root of your project, create the file ``spread.yaml`` and insert the
following contents:

.. code-block:: yaml
    :caption: project_name/spread.yaml

    project: project_name

    path: /project_name  

The ``project`` name should match the main directory's name.
The ``path`` designates the directory where the Spread
materials exist.

So that Spread knows about your tests, add the
following section to the end of ``spread.yaml``:

.. code-block:: yaml
    :caption: project_name/spread.yaml
    :emphasize-lines: 5-9

    project: project_name

    path: /project_name

    suites:
      tests/:
        summary: example test
        systems:
          - ubuntu-24.04-64

The ``suites`` section is how you tell Spread about the various Spread tests in
your project along with the systems you want Spread to use.
In this example, Spread looks for tests in the ``project_name/tests`` directory and
runs them on Ubuntu 24.04. 

Configure the Spread test to use Multipass
------------------------------------------

Each job in Spread has a backend, or a way to obtain a machine for running your Spread
tests. Spread can run on various backends, like
`Google <https://github.com/canonical/spread/blob/master/README.md#google>`__,
`QEMU <https://github.com/canonical/spread/blob/master/README.md#qemu>`__, or, as this
guide sets up, Multipass.

Include the following ``backends`` section of ``spread.yaml`` between the ``path`` and
``suites`` sections:

.. code-block:: yaml
    :caption: project_name/spread.yaml
    :emphasize-lines: 5-40

    project: project_name

    path: /project_name  

    backends:
      multipass:
        type: adhoc
        allocate: |
          multipass_image=24.04
          instance_name="example-multipass-vm"

          # Launch Multipass VM
          multipass launch --cpus 2 --disk 10G --memory 2G --name "${instance_name}" "${multipass_image}"

          # Enable PasswordAuthentication for root over SSH.
          multipass exec "$instance_name" -- \
            sudo sh -c "echo root:${SPREAD_PASSWORD} | sudo chpasswd"
          multipass exec "$instance_name" -- \
            sudo sh -c \
            "if [ -d /etc/ssh/sshd_config.d/ ]
            then
              echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config.d/10-spread.conf
              echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config.d/10-spread.conf
            else
              sed -i /etc/ssh/sshd_config -E -e 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' -e 's/^#?PermitRootLogin.*/PermitRootLogin yes/'
            fi"
          multipass exec "$instance_name" -- \
            sudo systemctl restart ssh

          # Get the IP from the instance
          ip=$(multipass info --format csv "$instance_name" | tail -1 | cut -d\, -f3)
          ADDRESS "$ip"

        discard: |
          instance_name="example-multipass-vm"
          multipass delete --purge "${instance_name}"

        systems:
          - ubuntu-24.04-64:
              workers: 1

    suites:
      tests/:
        summary: example test
        systems:
          - ubuntu-24.04-64

The ``backends`` section contains the following pieces:

* The backend is designated as ``type: adhoc`` as you must explicitly
  script the procedure to allocate and discard the Multipass VM. 
* The ``allocate`` section defines the image and name of the VM, launches the
  VM, and sets up the proper SSH permissions Spread then logs in to the VM with
  root permissions and inserts the Spread test. The last two lines tell Spread the
  IP address of the Multipass VM and set the environment variable ``ADDRESS``.
* The ``discard`` section deletes the Multipass VM once the Spread test
  has finished running.
* The ``systems`` key notes which systems the backend will use. Note that this key
  must match the ``systems`` used by at least one test under ``suites``.

Run tests locally
-----------------

List all available Spread tests in the code repository:

.. code-block:: bash

    spread --list

The terminal should respond with all the tests defined in ``spread.yaml``.
For example:

.. terminal::
    :dir: project_name

    spread --list

    multipass:ubuntu-24.04-64:tests/example_documentation_test

Run all Spread tests locally with ``spread``. You can also run a single
Spread test by specifying it like so:

.. code-block:: bash

    spread -vv -debug multipass:ubuntu-24.04-64:tests/example_documentation_test

Depending on the complexity of your test, Spread can take several minutes to complete.
The ``-vv -debug`` flags provide useful debugging information as the test runs.

Check the results
-----------------

The terminal will output various messages about allocating the Multipass VM,
connecting to the VM, sending the Spread test to the VM and executing the test.
If the test is successful, the terminal will output something similar to the following:

.. terminal::
    :output-only:

    2025-02-04 16:17:10 Successful tasks: 1
    2025-02-04 16:17:10 Aborted tasks: 0

Another sign of a successful test is whether the Multipass VM was deleted as expected.
Check by running :code:`multipass list`, and if the Spread test was successful
(and you have no other Multipass VMs created at the time), the terminal should
respond with the following:

.. terminal::
    :dir: project_name

    multipass list

    No instances found.

If the Spread test failed, then the ``-debug`` flag will open a shell into the
Multipass VM so that additional debugging can happen. In that case, the terminal
will output something similar to the following:

.. terminal::
    :output-only:

    2025-02-04 16:17:10 Starting shell to debug...
    2025-02-04 16:17:10 Sending script for multipass:ubuntu-24.04-64 (multipass:ubuntu-24.04-64:tests/example_documentation_test):


.. _ReStructuredText (.rst): https://www.sphinx-doc.org/en/master/usage/restructuredtext
.. _MyST-Markdown: https://myst-parser.readthedocs.io/en/latest
