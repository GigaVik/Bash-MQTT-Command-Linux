[RU](/README_RU.md) | **ENG**

# Bash-MQTT-Command-Linux

Bash script for executing commands remotely using MQTT.

This script connects to an MQTT broker and subscribes to a topic called `device/command`. It waits for incoming messages, which are expected to be shell commands to be executed on the current machine. The script executes the received command and sends the result back to the MQTT broker on a topic called `device/response`.

## Usage

Before running the script, change the following variables to fit your environment:

```
broker="your.mqtt.broker"
port="your-mqtt-broker-port"
topic="device/command"
response_topic="device/response"
client_id="device"
username="your-mqtt-username"
password="your-mqtt-password"
```

Once you've made those changes, run the script using:

```
bash mqtt-command-executor.sh
```

The script will connect to the MQTT broker and listen for incoming messages on the `device/command` topic. When a message is received, it will be executed in a shell, and the result will be sent back to the broker on the `device/response` topic.

## Warnings and Potential Issues

1. **Security Risk**: This script executes shell commands received from an MQTT broker. This can be extremely dangerous if the broker or the topic is not secure. An attacker could send malicious commands to your system.

2. **No Input Validation**: The script does not validate or sanitize the incoming commands. Any command received will be executed as-is, which could lead to unintended consequences.

3. **Dependence on MQTT Broker Security**: The security of this script heavily relies on the security of your MQTT broker. If the broker is compromised, your system could be as well.

4. **No Error Handling**: The script lacks robust error handling. If a command fails or the MQTT connection drops, the script may not handle it gracefully.

5. **Resource Usage**: Executing arbitrary commands can lead to high resource usage (CPU, memory, etc.), which could affect the performance of your system.

6. **No Logging**: The script does not log the commands executed or their results. This makes it difficult to audit or debug issues.

## License

GNU General Public License v3.0

Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.
