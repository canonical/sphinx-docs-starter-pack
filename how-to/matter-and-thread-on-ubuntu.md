# How to run Matter applications with Thread networking on Ubuntu

This is a tutorial on setting up and running Matter applications that use Thread
for networking on Ubuntu.
We will scope the tutorial to Matter applications built using the [Matter SDK]
and [OpenThread Border Router] (OTBR).

## Prerequisites 

- Two amd64/arm64 machines, with:
  - Ubuntu Server/Desktop 22.04 or newer
  - Thread [Radio Co-Processor (RCP)](https://openthread.io/platforms/co-processor#radio_co-processor_rcp)

In this tutorial, we'll use the following:

- Machine A
  - Ubuntu Desktop 23.10 amd64
  - Nordic Semiconductor nRF52840 dongle, using the OpenThread (OT) RCP firmware

- Machine B (Raspberry Pi 4)
  - Ubuntu Server 22.04 arm64
  - Nordic Semiconductor nRF52840 dongle, using the OT RCP firmware

 
Machine A will host the Border Router (OTBR) and Matter Controller.
Machine B will act as the Matter device and run the Matter application and
another instance of OTBR.
The second OTBR instance will not act as a Border Router, but rather as an agent
which complements the Matter application for Thread networking capabilities.

<!-- TODO: add diagram -->

```{note}

The API version of OTBR agents running on Machines A and B must match!

In this tutorial, we've used the following:

| Component           | Upstream Commit/Version                                                                                                      | API Version                                                                                                              | snap channel |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------ |
| Matter lighting app | connectedhomeip [`6b01cb9`](https://github.com/project-chip/connectedhomeip/commit/6b01cb977127eb8547ce66d5b627061dc2dd6c90) | -                                                                                                                        | -            |
| OTBR snap           | ot-br-posix [`thread-reference-20230119`](https://github.com/openthread/ot-br-posix/tree/thread-reference-20230119)          | [6](https://github.com/openthread/openthread/blob/thread-reference-20230119/src/lib/spinel/spinel.h#L380)                | latest/edge  |
| OTBR RCP firmware   | ot-nrf528xx [`00ac6cd`](https://github.com/openthread/ot-nrf528xx/tree/00ac6cd0137a4f09288b455bf8d7aa72d74062d1)             | [6](https://github.com/openthread/openthread/blob/9af0bfa60e373d81a5576b298d6664045870a375/src/lib/spinel/spinel.h#L420) | -            |


```


## 1. Set up Border Router on Machine A

Refer to {doc}`/how-to/otbr-on-ubuntu` to set up and configure OTBR.

Then form a Thread network, using the following commands:
```bash
sudo openthread-border-router.ot-ctl dataset init new
sudo openthread-border-router.ot-ctl dataset commit active
sudo openthread-border-router.ot-ctl ifconfig up
sudo openthread-border-router.ot-ctl thread start
```

<!-- TODO: explain what the commands do -->

These steps could also be performed with the Web GUI, served by default at [http://localhost:80](http://localhost:80).
Please refer to the instructions [here](https://openthread.io/guides/border-router/web-gui.md) to form, join, or check the status of a Thread network using the GUI.

---

The Thread network is now ready for new joiners.
Head over to Machine B to setup the Matter application.

## 2. Run OTBR on Machine B

The OTBR Agent is required for adding Thread networking capabilities to the
Matter application. 
The Matter app communicates with OTBR Agent via the DBus Message Bus.

Similar to Machine A, set up and configure OTBR by following: {doc}`/how-to/otbr-on-ubuntu`.

On Machine B, connecting the `avahi-control` interface isn't required as this OTBR Agent's DNS-SD registration isn't needed.

Note that we do not form a Thread network on Machine B.

## 3. Run Matter Application on Machine B

The Matter Application can implement any Matter functionality. The requirement
for this tutorial is that the application is created using the Matter SDK and
runs on Ubuntu.

````{tip}
Most reference examples from the Matter SDK support Thread networking. 
For example, the lighting app for Linux can run in Thread mode by setting
the `--thread` CLI argument. 
For more details, refer to its [README](https://github.com/project-chip/connectedhomeip/tree/master/examples/lighting-app/linux).
````

The recommended option here is to use the Pi GPIO Commander application,
which helps turn a Raspberry Pi into a Lighting Matter device 💡.
The application enables control of a GPIO pin via Matter.

There is a separate tutorial on setting up and running that application. 
Make sure to follow the Thread-related instructions to set it up and
start the application. Then head back here to
continue with Thread commissioning and control.

The tutorial for Pi GPIO Commander is available at: {doc}`/tutorial/pi-gpio-commander`

## 4. Control the Matter Application from Machine A


### Setup Matter Controller
First, install Chip Tool, a Matter Controller with a command-line interface:
```bash
sudo snap install chip-tool
```

Chip Tool depends on third-party services for DNS-SD and BLE discovery.
If you don't already have them, install Avahi Daemon and BlueZ:
```bash
sudo apt update
sudo apt install avahi-daemon bluez
```

Grant access to discover the Border Router over DNS-SD and the device over BLE:
```bash
sudo snap connect chip-tool:avahi-observe
sudo snap connect chip-tool:bluez
```

### Pair the device

Get the OTBR operational dataset (OTBR network's credentials), for the network
formed in previous sections:
```bash
sudo openthread-border-router.ot-ctl dataset active -x
```

Now, pair the Thread device over BLE:
```bash
sudo chip-tool pairing ble-thread 110 hex:<active-dataset> 20202021 3840
```
where:
- `110` is the assigned node ID for the app.
- `<active-dataset>` is the Thread network's Active Operational Dataset in hex, taken using the `ot-ctl` command above.
- `20202021` is the PIN code set on the app.
- `3840` is the discriminator ID.


If this succeeds, skip to the controlling the device.

If it didn't work, it may be because it has taken too long to reach this step and the device has stopped advertising and listening to commissioning requests. Try restarting it on the application on Machine B with `sudo snap restart matter-pi-gpio-commander`.

### Control the device

There are a few ways to control the device. The `toggle` command is stateless and the simplest:
```bash
sudo chip-tool onoff toggle 110 1
```

To turn on and off:
```bash
sudo chip-tool onoff on 110 1
sudo chip-tool onoff off 110 1
```


<!-- links -->
[OpenThread Border Router]: https://openthread.io/guides/border-router
[Matter SDK]: https://github.com/project-chip/connectedhomeip
[Chip Tool Snap]: https://snapcraft.io/chip-tool
