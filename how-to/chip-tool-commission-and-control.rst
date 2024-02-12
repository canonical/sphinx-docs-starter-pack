How to commission and control Matter devices with Chip Tool
===========================================================

Chip Tool is an open source Matter Controller with a command-line
interface (CLI). It is useful for development and testing of Matter
devices from a Linux machine.

Chip Tool offers a wide range of capabilities, ranging from device
commissioning and control to setup and operational payload generation
and parsing.

This document guides you through setting up and configuring Chip Tool
using a Snap. This makes it extremely easy to securely run and use the
tool on Linux.

Install
-------

First and foremost, make sure to have SnapD installed. It is
pre-installed on some distributions such as Ubuntu. Refer to
`installing SnapD <https://snapcraft.io/docs/installing-snapd>`_ for details.

Install the Chip Tool snap:

.. code:: shell

   sudo snap install chip-tool

You can choose another `channel <https://snapcraft.io/docs/channels>`_
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



Commission
----------

.. tabs::

   .. tab:: WiFi/Ethernet
      Discover using DNS-SD and pair:

      .. code:: shell

         sudo chip-tool pairing onnetwork 110 20202021

      where:

      -  ``110`` is the node id being assigned to the device
      -  ``20202021`` is the pin code set on the device
   
   .. tab:: Thread
      To commission a Thread device advertising itself over BLE,
      you need an active Thread network (formed by a Thread Border Router) and a Bluetooth interface.
      Chip Tool discovers the Thread Border Router via DNS-SD and communicates
      with it over WiFi/Ethernet network.


      Here, we assume the use of OpenThread implementation of the Thread Border Router.

      1. Obtain the Active Operational Dataset for the existing Thread network:

      .. tabs::

         .. tab:: Snap
            .. code:: shell
               
               sudo openthread-border-router.ot-ctl dataset active -x

         .. tab:: Docker
            .. code:: shell

               sudo docker exec -it otbr sh -c "sudo ot-ctl dataset active -x"

         .. tab:: Native
            .. code:: shell

               sudo ot-ctl dataset active -x

      The `dataset <https://openthread.io/reference/cli/concepts/dataset>`__ is encoded in hex and contains several values including the network's security key. 

      .. TODO: Link to Explanation

      2. Discover over Bluetooth Low Energy (BLE) and pair:

      .. code:: shell

         sudo chip-tool pairing ble-thread 110 hex:0e08...f7f8 20202021 3840

      where:

      -  ``110`` is the node id being assigned to the device
      -  ``0e08...f7f8`` is the Thread network credential operational dataset,
         truncated for readability.
      -  ``20202021`` is the pin code set on the device
      -  ``3840`` is the discriminator id


Control
-------

Toggle:

.. code:: shell

   sudo chip-tool onoff toggle 110 1

where:

-  ``onoff`` is the matter cluster name
-  ``on``/``off``/``toggle`` is the command name.
-  ``110`` is the node id of the app assigned during the commissioning
-  ``1`` is the endpoint of the configured device

More reading
------------

This documentation covered only some of common scenarios for commissioning and
controlling Matter devices via Chip Tool. 
The project provides a
`guide <https://github.com/project-chip/connectedhomeip/blob/master/docs/guides/chip_tool_guide.md#using-chip-tool-for-matter-device-testing>`__
with various usage examples. 

However, for a complete list of sub-commands and options, it is best to use the tool's usage instructions using the terminal.
