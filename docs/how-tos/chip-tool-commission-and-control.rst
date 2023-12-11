Commission and Control Matter Devices with Chip Tool
====================================================

Chip Tool is an open source Matter Controller with a command-line
interface (CLI). It is useful for development and testing of Matter
devices from a Linux machine.

Chip Tool offers a wide range of capabilities, ranging from device
commissioning and control to setup and operational payload generation
and parsing.

This document guides you through setting up and configuring Chip Tool
using a Snap. This makes it extremely easy to securely run and use the
tool on Linux.

Setup
-----

First and foremost, make sure to have SnapD installed. It is
pre-installed on some distros such as Ubuntu. Refer
`here <https://snapcraft.io/docs/installing-snapd>`_ for details.

Install Chip Tool snap:

.. code:: shell

   sudo snap install chip-tool

You may choose another `channel <https://snapcraft.io/docs/channels>`_
to install a development release.

The tool should now be available as ``chip-tool`` on your machine.

The snap restricts the tool's access to necessary resources on the host.
By default, the tool has access to the host network and is allowed to listen
on a port.

In addition, DNS-SD and Bluetooth access are usually required for commissioning:

.. code:: shell

   # To read DNS-SD registrations
   sudo snap connect chip-tool:avahi-observe
   # To discover and communicate over BLE
   sudo snap connect chip-tool:bluez

.. TODO: For details on the interfaces, refer to Chip Tool's connections (explanation)

.. note::
   On **Ubuntu Core**, the ``avahi-observe`` and ``bluez`` interfaces 
   are not provided by the system.

   These interfaces are provided by other snaps, such as the
   `Avahi <https://snapcraft.io/avahi>`_ and
   `BlueZ <https://snapcraft.io/bluez>`_ snaps. To install the snaps
   and connect to the interfaces, run:

   .. code:: shell

      sudo snap install avahi bluez
      sudo snap connect chip-tool:avahi-observe avahi:avahi-observe
      sudo snap connect chip-tool:bluez bluez:service

Usage Examples
--------------

Commissioning into Ethernet/WiFi network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Discover using DNS-SD and pair:

.. code:: shell

   sudo chip-tool pairing onnetwork 110 20202021

where:

-  ``110`` is the node id being assigned to the app
-  ``20202021`` is the pin code set on the app


Commissioning into Thread network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Obtain Thread network credential:

.. code:: shell

   $ sudo ot-ctl dataset active -x
   0e08...f7f8
   Done

Discover over Bluetooth Low Energy (BLE) and pair:

.. code:: shell

   sudo chip-tool pairing ble-thread 110 hex:0e08...f7f8 20202021 3840

where:

-  ``110`` is the node id being assigned to the device
-  ``0e08...f7f8`` is the Thread network credential operational dataset,
   truncated for readability.
-  ``20202021`` is the pin code set on the device
-  ``3840`` is the discriminator id

Control
~~~~~~~

Toggle:

.. code:: shell

   sudo chip-tool onoff toggle 110 1

where:

-  ``onoff`` is the matter cluster name
-  ``on``/``off``/``toggle`` is the command name.
-  ``110`` is the node id of the app assigned during the commissioning
-  ``1`` is the endpoint of the configured device

For additional usage examples, refer to `project's guide <https://github.com/project-chip/connectedhomeip/blob/master/docs/guides/chip_tool_guide.md#using-chip-tool-for-matter-device-testing>`__.
