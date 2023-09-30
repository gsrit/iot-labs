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
