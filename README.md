# Bash-MQTT-Command-Linux

Bash script for executing commands remotely using MQTT

This script connects to an MQTT broker and subscribes to a topic called openwrt/command. It waits for incoming messages, which are expected to be shell commands to be executed on the current machine. The script executes the received command and sends the result back to the MQTT broker on a topic called openwrt/response.


Usage

Before running the script, change the following variables to fit your environment:

```
broker="your.mqtt.broker"
port="your-mqtt-broker-port"
topic="openwrt/command"
response_topic="openwrt/response"
client_id="openwrt"
username="your-mqtt-username"
password="your-mqtt-password"
```

Once you've made those changes, run the script using bash mqtt-command-executor.sh. The script will connect to the MQTT broker and listen for incoming messages on the openwrt/command topic. When a message is received, it will be executed in a shell and the result sent back to the broker on the openwrt/response topic.
