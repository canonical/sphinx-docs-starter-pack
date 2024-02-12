How to set up OpenThread Border Router on Ubuntu
=================================================

The `OpenThread Border Router`_ (OTBR) is an open source Thread Border Router implementation.

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

Depending on the stability, we may need to pick a different 
`Snap Channel`_.

Grant access to resources
-------------------------


.. tabs::

    .. group-tab:: Ubuntu Server / Desktop

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
        On Ubuntu Core, we first need to install the BlueZ and Avahi snaps
        the system itself does not provide Bluetooth and DNS-SD interfaces.
        
        Install Avahi and BlueZ:

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

With everything configured, we can now start and enable the services:

.. code:: bash

    sudo snap start --enable openthread-border-router

Use the following command to query and follow the logs:

.. code:: bash

    snap logs -n 100 -f openthread-border-router
