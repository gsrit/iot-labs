# Monitoring the on/off status of a power supply using a GPIO input on a Raspberry Pi

To monitor the on/off status of a power supply using a GPIO input on a Raspberry Pi using shell commands, you can utilize the gpio command-line utility and some shell scripting. The gpio utility allows you to manipulate GPIO pins directly from the command line. Here's how you can do it:

## 1. Enable the GPIO Pins:
Before you can use GPIO pins from the command line, you need to make sure they are enabled. You can do this by running:

```
sudo raspi-config
```
Then, navigate to "Interfacing Options" and enable the "GPIO" interface.

## 2. Check the GPIO Pin Status:

You can use the gpio command to read the status of a GPIO pin. For example, if you want to monitor GPIO17:

```
gpio read 17
```
This command will return 0 if the pin is LOW (off) and 1 if the pin is HIGH (on).

You can create a shell script to continuously monitor the GPIO pin's status and display it in the terminal. Here's a simple example:

```
#!/bin/bash

# Set the GPIO pin number
GPIO_PIN=17

# Configure the GPIO pin as an input
gpio mode $GPIO_PIN in

while true; do
    STATUS=$(gpio read $GPIO_PIN)
    
    if [ $STATUS -eq 1 ]; then
        echo "Power supply is ON"
    else
        echo "Power supply is OFF"
    fi
    
    sleep 5  # Adjust the sleep interval as needed
done
```


