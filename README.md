[RU](README_RU.md) | **ENG**

# MQTT Command Processor

A Bash script to execute commands received via MQTT.

## Configuration

Before running the script, configure the settings in `config.ini`:

~~~
broker="your.mqtt.broker"
port="your-mqtt-broker-port"
topic="device/command"
response_topic="device/response"
client_id="device"
username="your-mqtt-username"
password="your-mqtt-password"
LOG_FILE="mqtt_script.log"
USE_WHITELIST="yes"
~~~

## Usage

1. Ensure `mosquitto_pub` and `mosquitto_sub` are installed.
2. Configure `config.ini` with your MQTT broker details.
3. Run the script:

   ~~~
   bash mqtt_command.sh
   ~~~

The script connects to the MQTT broker and listens for messages on the specified topic. It processes the messages and sends responses back to the broker.

## Security Warnings

- **Executing Received Commands**: When `USE_WHITELIST` is "no", the script executes any command received over MQTT, which is highly insecure. Only use this in a controlled environment.
- **Command Whitelist**: It is strongly recommended to keep `USE_WHITELIST` set to "yes" to only allow predefined commands.

## Risks of `USE_WHITELIST = "no"`

Setting `USE_WHITELIST` to "no" allows the script to execute **any command** received via MQTT. This can lead to severe consequences, including:

1. **System compromise and unauthorized access.**
2. **Data loss or corruption.**
3. **Installation and execution of malware.**
4. **Exhaustion of system resources (CPU, memory, disk).**
5. **Exploitation of network vulnerabilities.**
6. **Privilege escalation and gaining root access.**
7. **Manipulation or deletion of system logs.**
8. **Creation of backdoors or persistence mechanisms.**

## Logging

- All activities are logged to the file specified by `LOG_FILE`.
- The log includes message reception, processing, and responses sent.

## License

GNU General Public License v3.0
