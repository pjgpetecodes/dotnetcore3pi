#!/bin/bash

echo -e "\e[1m----------------------------------------"
echo -e "\e[1m       Dot Net Core Installer"
echo -e "\e[1m----------------------------------------"
echo ""
echo -e "\e[1mPete Codes / PJG Creations 2020"
echo ""
echo -e "Latest update 29/08/2021"
echo ""
echo "This will install the following;"
echo ""
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"
echo "- Dot Net Core 3.1.412"
echo "- ASP.NET Core 3.1.18"
echo ""
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"
echo -e "Any suggestions or questions, email \e[1;4mpete@pjgcreations.co.uk"
echo -e "\e[0mSend me a tweet \e[1;4m@pete_codes"
echo -e "\e[0mTutorials on \e[1;4mhttps://www.petecodes.co.uk"
echo ""
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis script must be run as root" 
   exit 1
fi

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m         Installing Dependencies"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

apt-get -y install libunwind8 gettext

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m     Getting Dot Net Core Binaries"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

cd ~/
wget https://download.visualstudio.microsoft.com/download/pr/5aef7e5d-2112-4868-8d7c-4c82f04363c5/e4fe30dc136634001cf357f26c825506/dotnet-sdk-3.1.412-linux-arm.tar.gz

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m       Getting ASP.NET Core Runtime"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

wget https://download.visualstudio.microsoft.com/download/pr/56d6e6bb-34e4-4e8e-8d6f-ce11be174182/6a3daf4d44793478df8f5f291cc8b029/aspnetcore-runtime-3.1.18-linux-arm.tar.gz

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m       Creating Main Directory"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

if [[ -d /opt/dotnet ]]; then
    echo "/opt/dotnet already  exists on your filesystem."
else
    echo "Creating Main Directory"
    echo ""
    mkdir /opt/dotnet
fi

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m    Extracting Dot NET Core Binaries"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

tar -xvf dotnet-sdk-3.1.412-linux-arm.tar.gz -C /opt/dotnet/

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m    Extracting ASP.NET Runtime"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

tar -xvf aspnetcore-runtime-3.1.18-linux-arm.tar.gz -C /opt/dotnet/

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m    Link Binaries to User Profile"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

ln -s /opt/dotnet/dotnet /usr/local/bin

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m    Make Link Permanent"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

if grep -q 'export DOTNET_ROOT=' /home/pi/.bashrc;  then
  echo 'Already added link to .bashrc'
else
  echo 'Adding Link to .bashrc'
  echo 'export DOTNET_ROOT=/opt/dotnet' >> /home/pi/.bashrc
fi

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m   Blazor Templates are now included!"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

#dotnet new -i Microsoft.AspNetCore.Components.WebAssembly.Templates::3.2.1

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m          Run dotnet --info"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

dotnet --info

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m              ALL DONE!"
echo ""
echo -e "\e[0mGo ahead and run \e[1mdotnet new console \e[0min a new directory!"
echo ""
echo ""
echo -e "Let me know how you get on by tweeting me at \e[1;5m@pete_codes"
echo ""
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"


