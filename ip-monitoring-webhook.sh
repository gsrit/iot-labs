#!/bin/bash

# Define the webhook URL
WEBHOOK_URL="YOUR_WEBHOOK_URL_HERE"

# Read the IP addresses and service types from iplist.txt
while read -r ip_address service; do
    if [ -z "$ip_address" ] || [ -z "$service" ]; then
        echo "Invalid line in iplist.txt: $ip_address $service"
        continue
    fi

    if [ "$service" == "PING" ]; then
        # Ping the host
        if ping -c 1 "$ip_address" > /dev/null; then
            echo "Host $ip_address is up."
        else
            # Host is down, send a webhook message
            message="Host $ip_address is down. Ping failed."
            curl -X POST -H "Content-Type: application/json" -d "{\"text\":\"$message\"}" "$WEBHOOK_URL"
            echo "Webhook message sent: $message"
        fi
    elif [[ "$service" == "Port_"* ]]; then
        port="${service#Port_}"
        # Check if the port is open
        if nc -z -w 2 "$ip_address" "$port"; then
            echo "Host $ip_address, Port $port is open."
        else
            # Port is closed or host is down, send a webhook message
            message="Host $ip_address, Port $port is down."
            curl -X POST -H "Content-Type: application/json" -d "{\"text\":\"$message\"}" "$WEBHOOK_URL"
            echo "Webhook message sent: $message"
        fi
    else
        echo "Unsupported service type: $service"
    fi
done < iplist.txt
