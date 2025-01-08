#!/bin/bash

# Check if the config file exists
if [ ! -f "./config.ini" ]; then
    echo "Config file not found."
    exit 1
fi

# Source the configuration file
. ./config.ini

# Function for sending messages
send_message() {
    local lines=("$@")
    mosquitto_pub -h "$broker" -p "$port" -i "$client_id" -t "$response_topic" -u "$username" -P "$password" -m "$(printf "%s\n" "${lines[@]}")" >> "$LOG_FILE" 2>&1
}

# Function for processing received messages
on_message() {
    message=$1
    echo "$(date): Processing message: $message" >> "$LOG_FILE"

    if [ "$USE_WHITELIST" = "yes" ]; then
        # Use command whitelist for security
        case "$message" in
            "status")
                result="System is running"
                ;;
            "version")
                result=$(cat /etc/os-release)
                ;;
            *)
                result="Unknown command"
                ;;
        esac
    else
        # WARNING: Executing received command directly. This is insecure.
        # Log the command for auditing purposes
        echo "$(date): Executing command: $message" >> "$LOG_FILE"
        # Execute the command and capture output
        result=$(eval "$message" 2>&1)
        if [ $? -ne 0 ]; then
            result="Command failed: $result"
        fi
    fi

    echo "$(date): Sending response: $result" >> "$LOG_FILE"
    send_message "$result"
}

# Main loop to receive and process messages
while true
do
    message=$(mosquitto_sub -h "$broker" -p "$port" -i "$client_id" -t "$topic" -u "$username" -P "$password" -C 1)
    if [ -n "${message// }" ]; then
        on_message "$message"
    fi
    sleep 1
done
