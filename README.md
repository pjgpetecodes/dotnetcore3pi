# Dot Net Core 3.1 with the Raspberry Pi

This is the source code to accompany my talk on Microsoft Dot Net Core 3 with the Raspberry Pi.

The Talk Details can be found here;

https://www.petecodes.co.uk/pete_talk/dot-net-core-3-0-on-the-raspberry-pi/

The Blog Post for this Talk can be found here;

http://bit.ly/dotnetcorerpi1

The Slides can be found here;

http://bit.ly/DotNetCoreRpiOxford

Tested on a Raspberry Pi 3B+ and a Raspberry Pi 4

Any Queries, contact me at;

https://www.petecodes.co.uk/contact/

Pete Gallagher / Pete Codes / PJG Creations 2020

# Dot Net Core 3 Installation on a Raspberry Pi

You can install Dot Net Core 3 on the Raspberry Pi in one command by executing;

```
wget -O - https://raw.githubusercontent.com/pjgpetecodes/dotnetcore3pi/master/install.sh | sudo bash
```

Full broken down installation instructions can be found at;

https://www.petecodes.co.uk/explorations-in-dot-net-core-3-0-for-raspberry-pi/

# Local Install Script

If you've cloned this repo, you can install Dot Net Core 3 by running the following in the root of the repo;

```
sudo chmod +x install.sh
sudo ./install.sh 

```

# IoT Hub Connection

The 3 IoT Hub Based Examples will require an IoT Hub Device Primary Connection String to work. 

# Deploying from VS Code on Windows

If you want to Deploy from VSCode on a Windows PC, then modify the RaspberryDeployWSL task's ```rsync``` command in the ```.vscode/tasks.json``` files in the various projects to point to your Pi IP Address;

```
"'sshpass -p \"raspberry\" rsync -rvuz $(wslpath '\"'${workspaceFolder}'\"')/bin/linux-arm/publish/ pi@[Enter Your IP Address]:share/${workspaceFolderBasename}/'"
```

Replace the ```[Enter Your IP Address]``` Section with the IP Address of your Pi (No Square Brackets!).

You will also need to change the username (```pi@```) and password (```-p \"raspberry"```) if you have altered those too.

# Debugging from VS Code on Windows

If you want to Debug from VSCode on a Windows PC, then modify the ```.NET Core Launch Console``` task in the ```.vscode/launch.json``` files in the various projects to point to your Pi's Hostname;

```
"pipeArgs": [
    "-pw",
    "raspberry",
    "root@[Your Pi Hostname].local"
],
```

You'll also need to install the VS Debugger;

```
curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -r linux-arm -v latest -l ~/vsdbg
```

You may also need to install curl and zip if they're not already installed;

```
sudo apt-get install curl
```
