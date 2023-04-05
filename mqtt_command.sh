#!/bin/bash

broker="your.mqtt.broker"
port="your-mqtt-broker-port"
topic="device/command"
response_topic="device/response"
client_id="device"
username="your-mqtt-username"
password="your-mqtt-password"

#Setting LC_CTYPE for Cyrillic support in messages
#export LC_CTYPE=ru_RU.UTF-8

#Function for sending messages in array format
send_message() {
  lines=("$@")
  result_array=("${lines[@]}")
  mosquitto_pub -h "$broker" -p "$port" -i "$client_id" -t "$response_topic" -u "$username" -P "$password" -m "$(printf "%s\n" "${result_array[@]}")"
}


#Function for processing received messages
on_message() {
  message=$1


#If the message is not empty, execute processing
  if [ -n "$message" ]
  then
      # Display the received message
      echo "Received message: $message"
      # Execute the received command in shell and save the result
      result=$(eval "$message")
      # Send an empty message to the command topic to remove the message from the queue
      mosquitto_pub -h "$broker" -p "$port" -i "$client_id" -t "$topic" -m "" -u "$username" -P "$password"
      # Send the result of the command execution in array format
      send_message "${result}"
  fi
  }

# Connecting to MQTT broker using login and password
while true
do
  message=$(mosquitto_sub -h "$broker" -p "$port" -i "$client_id" -t "$topic" -u "$username" -P "$password" -C 1)
  if [ -n "${message// }" ]
  then
    # Process the received message
    on_message "$message"
  fi
done
