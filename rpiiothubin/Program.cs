using System;
using System.Device.Gpio;
using Microsoft.Azure.Devices.Client;
using System.Text;

namespace rpitest
{
    class Program
    {

        private static readonly string connectionString = "HostName=petecodesiothub.azure-devices.net;DeviceId=raspberrypi;SharedAccessKey=lr26Kjr0S4jrsZNwlOVSLY0WSTTnKQ+Vtz02/rimH9A=";
        private static DeviceClient deviceClient;

        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            deviceClient = DeviceClient.CreateFromConnectionString(connectionString);
            
            ReceiveCloudToDeviceMessageAsync();

            GpioController controller = new GpioController(PinNumberingScheme.Board);
            var pin = 10;
            var buttonPin = 26;
            var buttonPressed = false;
            
            controller.OpenPin(pin, PinMode.Output);
            controller.OpenPin(buttonPin, PinMode.InputPullUp);            

            try
            {
                while (true)
                {
                    if (controller.Read(buttonPin) == false)
                    {
                        controller.Write(pin, PinValue.High);

                        if (buttonPressed == false)
                        {
                            buttonPressed = true;
                            SendDeviceToCloudMessageAsync();
                        }
                    }
                    else
                    {
                        controller.Write(pin, PinValue.Low);
                        buttonPressed = false;
                    }
                }
            }
            finally
            {
                controller.ClosePin(pin);
            }
        }

        private static async void SendDeviceToCloudMessageAsync()
        {
            var messageString = "Button Pressed";
            Message message = new Message(Encoding.ASCII.GetBytes(messageString));

            message.Properties.Add("buttonEvent", "true");

            await deviceClient.SendEventAsync(message);
            Console.WriteLine("Sending Message {0}", messageString);

        }

        private static async void ReceiveCloudToDeviceMessageAsync()
        {
            Console.WriteLine("Receiving Cloud to Device messages from IoT Hub");

            while (true)
            {
                Message receivedMessage = await deviceClient.ReceiveAsync();
                
                if (receivedMessage != null) 
                {
                    string receivedMessageString = Encoding.ASCII.GetString(receivedMessage.GetBytes());
                    Console.WriteLine("Received message: {0}", receivedMessageString);
                    await deviceClient.CompleteAsync(receivedMessage);
                }
                
            }
        }
    }
}