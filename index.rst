Matter on Ubuntu
================

Matter is an open source connectivity standard for smart home.
It is a collection of protocols for connecting compatible devices in a secure
and reliable way.

This documentation is for building and running Matter devices on Ubuntu.
It provides guidance, examples and reference.

Matter on Ubuntu simplifies and streamlines the work of building matter
applications, by providing rich and established developer tools.
It is intended to serve developers and maintainers of Linux-based Matter
applications.

In this documentation
---------------------

Get started
~~~~~~~~~~~

For your first experience with Matter on Ubuntu, you can use easily-available
hardware to explore and understand its basics. 

.. toctree::
   :maxdepth: 1

   Build a Matter device with Raspberry Pi <tutorial/pi-gpio-commander>

How-to guides
~~~~~~~~~~~~~

Guides for specific real-world problems and tasks.

.. toctree::
   :maxdepth: 1

   Manage devices with Chip Tool <how-to/chip-tool-commission-and-control>
   Set up OpenThread Border Router <how-to/otbr-on-ubuntu>
   Run Matter apps with Thread networking <how-to/matter-and-thread-on-ubuntu>
   Create an OS image with OTBR <how-to/otbr-ubuntu-core-image>
   Install Home Assistant on Ubuntu Core <how-to/home-assistant-ubuntu-core>


Project and community
---------------------

Matter on Ubuntu references existing open source implementations.
The Matter standard and SDK are supported by the Connectivity Standards Alliance (CSA).

Canonical is responsible for Snap packages presented in this documentation:

- `Chip Tool <https://snapcraft.io/chip-tool>`_
- `OpenThread Border Router <https://snapcraft.io/openthread-border-router>`_
- `Matter Pi GPIO Commander <https://snapcraft.io/matter-pi-gpio-commander>`_

Other resources:

- `Matter Standard <https://csa-iot.org/all-solutions/matter/>`_
- `Matter SDK <https://github.com/project-chip/connectedhomeip>`_
