Creating an OS Image with OpenThread Border Router
==================================================

This tutorial walks you through creating an OS image that is pre-loaded with
OpenThread Border Router (OTBR).
We use Ubuntu Core as the Linux distribution because it is optimized for IoT and
is secure by design.
We configure the image and bundle the snapped version of OTBR.
After the deployment, the snaps will continue to receive updates for the latest
security and bug fixes.

The Ubuntu documentation has an in-depth explanation for Ubuntu Core, covering 
various concepts. It is recommended to read that documentation, 
`here <https://ubuntu.com/core/docs/uc20/inside>`_.

Requirements:

- An amd64 Ubuntu development environment
- An amd64 machine as target for installing the new OS
- A Thread Radio Co-processor (RCP), connected to the target machine.

Used in this tutorial:

- Desktop computer running Ubuntu 23.10
- Intel NUC11TNH with 8GB RAM and 250GB NAND flash storage
- `Nordic Semiconductor nRF52840 Dongle <https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle>`_, connected to Intel NUC


We need the following tools on the development environment:

- `snapcraft <https://snapcraft.io/snapcraft>`_ to manage keys in the store and build snaps
- `yq <https://snapcraft.io/yq>`_ to validate YAML files and convert them to JSON
- `ubuntu-image <https://snapcraft.io/ubuntu-image>`_ v2 to build the Ubuntu Core image
  
Install them using the following commands:

.. code:: bash
    
    sudo snap install snapcraft --classic
    sudo snap install yq
    sudo snap install ubuntu-image --classic

Create a custom gadget
----------------------
Overriding the snap configurations upon installation is possible with a
`gadget snap <https://snapcraft.io/docs/the-gadget-snap>`_.

The
`pc gadget <https://snapcraft.io/pc>`_ is available as a pre-built snap in the
store, however, in this chapter, we need to build our own to include custom
configurations and interface connections.

We will create our custom gadget by staging the latest stable core22 gadget,
and making the necessary modifications.

We need to create two files:

- :code:`snapcraft.yaml`: the definition of our custom Gadget snap. We need this custom gadget in order to ship snap configurations on our image.
- :code:`gadget.yaml`: the volumes layout for the image, list of snap default configuration, and interface connections.

Create the :code:`snapcraft.yaml` file with the following content:

.. literalinclude:: snapcraft.yaml
  :language: YAML

.. TODO: is it possible to append the custom gadget snippets to the staged gadget?

Then, create the :code:`gadget.yaml` file :

.. literalinclude:: gadget.yaml
  :language: YAML

Build the gadget snap:

.. code:: bash
    
    snapcraft --verbose

This results in creating a snap named :code:`otbr-gadget_test_amd64.snap`.

.. note::
    You need to rebuild the snap every time you change the :code:`gadget.yaml` file.

Create the model assertion
---------------------------

The 
`model assertion <https://ubuntu.com/core/docs/reference/assertions/model>`_ is
a digitally signed document that describes the content of the Ubuntu Core image.

Below is an example model assertion in YAML, describing a :code:`core22` Ubuntu Core
image:

.. literalinclude:: model.yaml
  :language: YAML

Refer to the model assertion documentation and inline comments for details.
Create a :code:`model.yaml` with the above content, replacing :code:`authority-id`,
:code:`brand-id`, and :code:`timestamp`.

.. note::
    Unlike the official documentation which uses JSON, we use YAML
    serialization for the model.
    This is for consistency with all the other serialization formats in this tutorial.
    Moreover, it allows us to comment out some parts for testing or add comments to
    describe the details inline.

To find you developer ID, use the Snapcraft CLI:

.. code:: console
    
    $ snapcraft whoami
    ...
    developer-id: <developer-id>


or get it from the
`Snapcraft Dashboard <https://dashboard.snapcraft.io/dev/account/>`_.

Follow
`these instructions <https://snapcraft.io/docs/creating-your-developer-account>`_
to create a developer account, if you don't already have one.

Next, we need to sign the model assertion:

Refer to
`this article <https://ubuntu.com/core/docs/custom-images#heading--signing>`_ for
details on how to sign the model assertion. 

Here are the needed steps:

1) Create and register a key

.. code:: bash

    snap login
    snap keys
    # Continue if you have no existing keys.
    # You'll be asked to set a passphrase which is needed before signing
    snap create-key otbr-uc-tutorial
    snapcraft register-key otbr-uc-tutorial

We now have a registered key named :code:`otbr-uc-tutorial` which we'll use later.

2) Sign the model assertion

We sign the model using the :code:`otbr-uc-tutorial` key created and registered earlier. 

The :code:`snap sign` command takes JSON as input and produces YAML as output!
We use the YQ app to convert our model assertion to JSON before passing it in
for signing.

.. code:: bash

    yq eval model.yaml -o=json | snap sign -k otbr-uc-tutorial > model.signed.yaml


This will produce a signed model named :code:`model.signed.yaml`.

.. note::
    You need to repeat the signing every time you change the input model, because
    the signature is calculated based on the model.

Build the Ubuntu Core image
---------------------------

We use :code:`ubuntu-image` and set the path to:

- The signed model assertion YAML file.
- The locally built gadget snap.

.. code:: bash

    ubuntu-image snap model.signed.yaml --verbose --validation=enforce \
        --snap otbr-gadget_test_amd64.snap

This downloads all the snaps specified in the model assertion and builds
an image file called :code:`pc.img`.

✅ The image file is now ready to be flashed on a medium to create a bootable drive
with the Ubuntu Core installer!

Install the Ubuntu Core image
-----------------------------

The installation instructions are device specific.
You may refer to Ubuntu Core section in
`this page <https://ubuntu.com/download/iot>`_. For example:

- `Intel NUC <https://ubuntu.com/download/intel-nuc>`_ - applicable to most computers with a secondary storage

.. - [Raspberry Pi](https://ubuntu.com/download/raspberry-pi)

A precondition to continue with some of the instructions is to compress
:code:`pc.img`.
This speeds up the transfer and makes the input file similar to official images,
improving compatibility with the official instructions.

To compress with the lowest compression rate of zero:

.. code:: bash
    
    xz -vk -0 pc.img

A higher compression rate significantly increases the processing time and needed
resources, with very little gain.

Now, follow the device specific instructions.

✅ Continue to perform the OS initialization steps appearing `by default`.

Once the installation is complete, you will see the interface of the
:code:`console-conf` program.
It will walk you through the networking and user account setup.
You'll need to enter the email address of your Ubuntu account to create an OS
user account with your registered username and have your SSH public keys
deployed as authorized SSH keys for that user.
If you haven't done so in the past, refer to the
`Creating your developer account documentation <https://snapcraft.io/docs/creating-your-developer-account>`_
to add your SSH keys before doing this setup.

Read about
`system user assertion <https://ubuntu.com/core/docs/system-user>`_
to know how the manual account setup looks like and how it can be automated.

✅ Congratulations. The Ubuntu Core installation is complete and the device
is ready for use. The OTBR services should be running and functional.

.. TODO: add usb installation steps

.. TODO: add sanity check steps
