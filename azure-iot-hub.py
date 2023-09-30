import os
import time
from azure.iot.device import IoTHubDeviceClient, Message

# Define your connection string here
CONNECTION_STRING = "HostName=RaspberryConnectHub.azure-devices.net;DeviceId=xxxxxx;SharedAccessKey=xxxxxxxxxxxxxxxxxxx"



def get_cpu_temperature():
    try:
        # Read the CPU temperature from the system
        temperature = float(os.popen("vcgencmd measure_temp").readline().replace("temp=", "").replace("'C\n", ""))
        return temperature
    except Exception as e:
        print("Error reading CPU temperature:", str(e))
        return None

def iothub_client_init():
    client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
    return client

def iothub_client_telemetry_sample_run():
    try:
        client = iothub_client_init()
        print("Sending data to IoT Hub, press Ctrl-C to exit")
        while True:
            # Get the CPU temperature
            cpu_temperature = get_cpu_temperature()
            if cpu_temperature is not None:
                msg_txt_formatted = '{{"cpu_temperature": {temperature}}}'.format(temperature=cpu_temperature)
                message = Message(msg_txt_formatted)
                print("Sending message: {}".format(message))
                client.send_message(message)
                print("Message successfully sent")
            time.sleep(15)
    except KeyboardInterrupt:
        print("IoTHubClient stopped")

if __name__ == '__main__':
    print("Press Ctrl-C to exit")
    iothub_client_telemetry_sample_run()
