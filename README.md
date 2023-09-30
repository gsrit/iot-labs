# Monitoring the on/off status of a power supply using a GPIO input on a Raspberry Pi

To monitor the on/off status of a power supply using a GPIO input on a Raspberry Pi using shell commands, you can utilize the gpio command-line utility and some shell scripting. The gpio utility allows you to manipulate GPIO pins directly from the command line. Here's how you can do it:

## 1. Enable the GPIO Pins:
Before you can use GPIO pins from the command line, you need to make sure they are enabled. You can do this by running:

```
sudo raspi-config

