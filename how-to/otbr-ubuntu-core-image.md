# How to create an OS Image with OpenThread Border Router

This tutorial walks you through creating an OS image that is pre-loaded with
OpenThread Border Router (OTBR).
We use Ubuntu Core as the Linux distribution because it is optimized for IoT and
is secure by design.
We configure the image and bundle the snapped version of OTBR.
After the deployment, the snaps will continue to receive updates for the latest
security and bug fixes.

Before starting, it is recommended to read the documentation on 
[Ubuntu Core components](https://ubuntu.com/core/docs/components)
and get familiar with various useful concepts.

Requirements:

- An amd64 Ubuntu development environment
- An amd64 machine as target for installing the new OS
- A Thread Radio Co-processor (RCP), connected to the target machine.

Used in this tutorial:

- Desktop computer running Ubuntu 23.10
- Intel NUC11TNH with 8GB RAM and 250GB NAND flash storage
- [Nordic Semiconductor nRF52840 Dongle](https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle), connected to Intel NUC


We need the following tools on the development environment:

- [snapcraft](https://snapcraft.io/snapcraft) to manage keys in the store and build snaps
- [yq](https://snapcraft.io/yq) to validate YAML files and convert them to JSON
- [ubuntu-image](https://snapcraft.io/ubuntu-image) v2 to build the Ubuntu Core image
  
Install them using the following commands:

```bash
sudo snap install snapcraft --classic
sudo snap install yq
sudo snap install ubuntu-image --classic
```

## Create a custom gadget

Overriding the snap configurations upon installation is possible with a
[gadget snap](https://snapcraft.io/docs/the-gadget-snap).

The
[pc gadget](https://snapcraft.io/pc) is available as a pre-built snap in the
store, however, in this chapter, we need to build our own to include custom
configurations and interface connections.

We will create our custom gadget by staging the latest stable core22 gadget,
and making the necessary modifications.

We need to create two files:

- `snapcraft.yaml`: the definition of our custom Gadget snap. We need this custom gadget in order to ship snap configurations on our image.
- `gadget.yaml`: the volumes layout for the image, list of snap default configuration, and interface connections.

Create the `snapcraft.yaml` file with the following content:

```{literalinclude} otbr-ubuntu-core-image/snapcraft.yaml
:language: YAML
```

<!-- 
TODO: is it possible to append the custom gadget snippets to the staged gadget?
-->

Then, create the `gadget.yaml` file :

```{literalinclude} otbr-ubuntu-core-image/gadget.yaml
:language: YAML
```

Build the gadget snap:

```bash
snapcraft --verbose
```

This results in creating a snap named `otbr-gadget_test_amd64.snap`.

```{note}
You need to rebuild the snap every time you change the `gadget.yaml` file.
```

## Create the model assertion

The 
[model assertion](https://ubuntu.com/core/docs/reference/assertions/model) is
a digitally signed document that describes the content of the Ubuntu Core image.

Below is an example model assertion in YAML, describing a `core22` Ubuntu Core
image:

```{literalinclude} otbr-ubuntu-core-image/model.yaml
:language: YAML
```

Refer to the model assertion documentation and inline comments for details.
Create a `model.yaml` with the above content, replacing `authority-id`,
`brand-id`, and `timestamp`.

```{note}
Unlike the official documentation which uses JSON, we use YAML
serialization for the model.
This is for consistency with all the other serialization formats in this tutorial.
Moreover, it allows us to comment out some parts for testing or add comments to
describe the details inline.
```

To find you developer ID, use the Snapcraft CLI:

```console
$ snapcraft whoami
...
developer-id: <developer-id>
```

or get it from the
[Snapcraft Dashboard](https://dashboard.snapcraft.io/dev/account/).

Follow
[these instructions](https://snapcraft.io/docs/creating-your-developer-account)
to create a developer account, if you don't already have one.

Next, we need to sign the model assertion. Refer to
[this article](https://ubuntu.com/core/docs/sign-model-assertion) for
details on how to sign the model assertion. 
Here are the needed steps:

1) Create and register a key

```bash
snap login
snap keys
# Continue if you have no existing keys.
# You'll be asked to set a passphrase which is needed before signing
snap create-key otbr-uc-tutorial
snapcraft register-key otbr-uc-tutorial
```

We now have a registered key named `otbr-uc-tutorial` which we'll use later.

2) Sign the model assertion

We sign the model using the `otbr-uc-tutorial` key created and registered earlier. 

The `snap sign` command takes JSON as input and produces YAML as output!
We use the YQ app to convert our model assertion to JSON before passing it in
for signing.

```bash
yq eval model.yaml -o=json | snap sign -k otbr-uc-tutorial > model.signed.yaml
```


This will produce a signed model named `model.signed.yaml`.

```{note}
You need to repeat the signing every time you change the input model, because
the signature is calculated based on the model.
```    

## Build the Ubuntu Core image

We use `ubuntu-image` and set the path to:

- The signed model assertion YAML file.
- The locally built gadget snap.

```bash
ubuntu-image snap model.signed.yaml --verbose --validation=enforce \
    --snap otbr-gadget_test_amd64.snap
```

This downloads all the snaps specified in the model assertion and builds
an image file called `pc.img`.

✅ The image file is now ready to be flashed on a medium to create a bootable drive
with the Ubuntu Core installer!

## Install the Ubuntu Core image

The installation instructions are device specific.
You may refer to Ubuntu Core section in
[this page](https://ubuntu.com/download/iot). For example:

- [Intel NUC](https://ubuntu.com/download/intel-nuc) - applicable to most computers with a secondary storage

<!--
[Raspberry Pi](https://ubuntu.com/download/raspberry-pi)
-->

A precondition to continue with some of the instructions is to compress `pc.img`.
This speeds up the transfer and makes the input file similar to official images,
improving compatibility with the official instructions.

To compress with the lowest compression rate of zero:

```bash
xz -vk -0 pc.img
```

A higher compression rate significantly increases the processing time and needed
resources, with very little gain.

Now, follow the device specific instructions.

✅ Continue to perform the OS initialization steps appearing *by default*.

Once the installation is complete, you will see the interface of the
`console-conf` program.
It will walk you through the networking and user account setup.
You'll need to enter the email address of your Ubuntu account to create an OS
user account with your registered username and have your SSH public keys
deployed as authorized SSH keys for that user.
If you haven't done so in the past, refer to the
[Creating your developer account documentation](https://snapcraft.io/docs/creating-your-developer-account)
to add your SSH keys before doing this setup.

Read about
[system user assertion](https://ubuntu.com/core/docs/system-user)
to know how the manual account setup looks like and how it can be automated.

✅ Congratulations. The Ubuntu Core installation is complete and the device
is ready for use. The OTBR services should be running and functional.

<!--
TODO: add usb installation steps
TODO: add sanity check steps
-->

### Sanity check

Now, let's verify that everything is in place and functional.

Connect to the machine over SSH:
```console
$ ssh <ubuntu-one-username>@<device-ip>
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-91-generic x86_64)

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

 * Ubuntu Core:     https://www.ubuntu.com/core
 * Community:       https://forum.snapcraft.io
 * Snaps:           https://snapcraft.io

This Ubuntu Core 22 machine is a tiny, transactional edition of Ubuntu,
designed for appliances, firmware and fixed-function VMs.

If all the software you care about is available as snaps, you are in
the right place. If not, you will be more comfortable with classic
deb-based Ubuntu Server or Desktop, where you can mix snaps with
traditional debs. It's a brave new world here in Ubuntu Core!

Please see 'snap --help' for app installation and updates.
```

List the installed snaps:
```console
<user>@ubuntu:~$ snap list
Name                      Version                         Rev    Tracking       Publisher           Notes
avahi                     0.8                             327    22/stable      ondra               -
bluez                     5.64-4                          356    22/stable      canonical✓          -
core22                    20231123                        1033   latest/stable  canonical✓          base
openthread-border-router  thread-reference-20230119+snap  37     latest/edge  canonical-iot-labs  -
otbr-gadget               test                            x1     -              -                   gadget
pc-kernel                 5.15.0-91.101.1                 1540   22/stable      canonical✓          kernel
snapd                     2.60.4                          20290  latest/stable  canonical✓          snapd
```

✅ Avahi, BlueZ, and openthread-border-router are installed.

Check the running snap services:
```console
<user>@ubuntu:~$ snap services
Service                              Startup  Current   Notes
avahi.daemon                         enabled  active    -
bluez.bluez                          enabled  active    -
openthread-border-router.otbr-agent  enabled  active    -
openthread-border-router.otbr-setup  enabled  inactive  -
openthread-border-router.otbr-web    enabled  active    -
```

✅ Avahi and BlueZ's services are enabled and active.  
✅ The OTBR agent and web server are enabled and active.  
✅ The OTBR setup oneshot service is enabled, but inactive.
It is enabled because it needs to run on every boot to setup the firewall and network.
It is inactive because it has completed its work and exited.

Check the snap connections:
```console
<user>@ubuntu:~$ snap connections openthread-border-router 
Interface          Plug                                        Slot                                 Notes
avahi-control      openthread-border-router:avahi-control      avahi:avahi-control                  gadget
bluetooth-control  openthread-border-router:bluetooth-control  :bluetooth-control                   gadget
bluez              openthread-border-router:bluez              bluez:service                        gadget
dbus               -                                           openthread-border-router:dbus-wpan0  -
firewall-control   openthread-border-router:firewall-control   :firewall-control                    gadget
network            openthread-border-router:network            :network                             -
network-bind       openthread-border-router:network-bind       :network-bind                        -
network-control    openthread-border-router:network-control    :network-control                     gadget
raw-usb            openthread-border-router:raw-usb            :raw-usb                             gadget
    
```

✅ The connections with `gadget` in the Note match those defined as
`connections` in our gadget.

Finally, check the snap configurations:
```console
<user>@ubuntu:~$ snap get openthread-border-router 
Key        Value
autostart  true
infra-if   enp88s0
radio-url  spinel+hdlc+uart:///dev/ttyACM0
thread-if  wpan0
```

✅ The values are according to the `defaults` set in our gadget.

You may further continue by checking the logs, for example with `snap logs -n 100 -f openthread-border-router`.

