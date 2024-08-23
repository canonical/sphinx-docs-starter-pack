How to set up OpenThread Border Router on Ubuntu
=================================================

The `OpenThread Border Router <https://openthread.io/guides/border-router>`_ (OTBR) is an open source Thread Border Router implementation.

A Thread Border Router acts as a gateway between Thread and other IP networks
(e.g. WiFi, Ethernet).

In this how to, we will go through the steps to quickly setup OTBR on Ubuntu.

.. note::
    In order to setup OTBR, we need a Radio Co-Processor (RCP) and another IP 
    networking interface such as WiFi or Ethernet.

    Moving forward, the assumption is to have the RCP available as a device at 
    :code:`/dev/ttyACM0`. 

    .. TODO: add link to a document explaining how to get the Radio URL.

We use the (unofficial) `OTBR Snap`_ because it makes the setup, configuration,
and maintenance significantly simpler.
Let's get started:

Install the OTBR snap
---------------------

Install the latest version from the Snap Store:

.. code:: bash

    sudo snap install openthread-border-router

.. tip::
   Pre-release versions of OpenThread Border Router are available in different
   `channels <https://snapcraft.io/docs/channels>`_.


Grant access to resources
-------------------------


.. tabs::

    .. group-tab:: Ubuntu Server / Desktop

        Install the dependencies:

        .. code:: bash
            
            sudo apt update
            sudo apt install bluez avahi-daemon
        
        
        Connect the following interfaces:

        .. code:: bash

            # Allow setting up the firewall
            sudo snap connect openthread-border-router:firewall-control
            # Allow access to USB Thread Radio Co-Processor (RCP)
            sudo snap connect openthread-border-router:raw-usb
            # Allow setting up the networking
            sudo snap connect openthread-border-router:network-control
            # Allow controlling the Bluetooth devices
            sudo snap connect openthread-border-router:bluetooth-control

            # Allow device discovery over Bluetooth Low Energy
            sudo snap connect openthread-border-router:bluez
            # Allow DNS-SD registration and discovery
            sudo snap connect openthread-border-router:avahi-control

    .. group-tab:: Ubuntu Core
        
        Install the dependencies:

        .. code:: bash
            
            sudo snap install bluez avahi
        

        Connect the following interfaces:

        .. code:: bash
            
            # Allow setting up the firewall
            sudo snap connect openthread-border-router:firewall-control
            # Allow access to USB Thread Radio Co-Processor (RCP)
            sudo snap connect openthread-border-router:raw-usb
            # Allow setting up the networking
            sudo snap connect openthread-border-router:network-control
            # Allow controlling the Bluetooth devices
            sudo snap connect openthread-border-router:bluetooth-control
            
            # Allow device discovery over Bluetooth Low Energy
            sudo snap connect openthread-border-router:bluez bluez:service
            # Allow DNS-SD registration and discovery
            sudo snap connect openthread-border-router:avahi-control avahi:avahi-control

            
            

Configure the OTBR snap
-----------------------

The configurations are set via `Snap Configuration Options`_ and passed on the
services.

First, check the default configurations:

.. code:: console
    
    $ sudo snap get openthread-border-router 
    Key        Value
    autostart  false
    infra-if   wlan0
    radio-url  spinel+hdlc+uart:///dev/ttyACM0
    thread-if  wpan0

Then, override them based on the local setup.

For example, if the networking interface is :code:`eth0`, change it as follows:

.. code:: bash
    
    snap set openthread-border-router infra-if="eth0"


Start OTBR
----------

By default the services are disabled and not started.
After everything is configured, we can start and enable the services:

.. code:: bash

    sudo snap start --enable openthread-border-router

Use the following command to query and follow the logs:

.. code:: bash

    snap logs -n 100 -f openthread-border-router

.. note:: 
    To start and enable via a `Gadget snap <https://snapcraft.io/docs/the-gadget-snap>`_, set `autostart` to `true`.


Form a Thread network
---------------------

Use the CTL tool to initialize the Thread network:

.. code:: bash

    sudo openthread-border-router.ot-ctl dataset init new
    sudo openthread-border-router.ot-ctl dataset commit active
    sudo openthread-border-router.ot-ctl ifconfig up
    sudo openthread-border-router.ot-ctl thread start

Alternatively, these steps could be performed with the GUI at `http://localhost:80 <http://localhost:80>`_.
Please refer to the instructions `here <https://openthread.io/guides/border-router/web-gui.md>`_ to configure and form, join, or check the status of a Thread network using the GUI.


Controlling a Thread device
---------------------------

To commission and control a Matter Thread device, you can use Chip Tool; refer to :doc:`chip-tool-commission-and-control`.
