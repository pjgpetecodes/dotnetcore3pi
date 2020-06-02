#!/bin/bash

echo -e "\e[1m----------------------------------------"
echo -e "\e[1m       Dot Net Core Installer"
echo -e "\e[1m----------------------------------------"
echo ""
echo -e "\e[1mPete Codes / PJG Creations 2020"
echo ""
echo -e "Latest update 30/04/2020"
echo ""
echo "This will install the following;"
echo ""
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"
echo "- Dot Net Core 3.1.201"
echo "- ASP.NET Core 3.1.3"
echo "- Blazor Preview 5 2016.8"
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
echo -e "\e[1m           Performing Updates"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

read -p "Do you wish to do perform a system update and upgrade first? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Performing System Update and Upgrade"
    echo ""
    apt-get -y update
    apt-get -y upgrade
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
wget https://download.visualstudio.microsoft.com/download/pr/f2e1cb4a-0c70-49b6-871c-ebdea5ebf09d/acb1ea0c0dbaface9e19796083fe1a6b/dotnet-sdk-3.1.300-linux-arm.tar.gz

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m       Getting ASP.NET Core Runtime"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

wget https://download.visualstudio.microsoft.com/download/pr/06f9feeb-cd19-49e9-a5cd-a230e1d8c52f/a232fbb4a6e6a90bbe624225e180308a/aspnetcore-runtime-3.1.4-linux-arm.tar.gz

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

tar -xvf dotnet-sdk-3.1.300-linux-arm.tar.gz -C /opt/dotnet/

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m    Extracting ASP.NET Runtime"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

tar -xvf aspnetcore-runtime-3.1.4-linux-arm.tar.gz -C /opt/dotnet/

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

if grep -q 'export DOTNET_ROOT=/opt/dotnet' ~/.bashrc;  then
  echo 'Already added link to .bashrc'
else
  echo 'Adding Link to .bashrc'
  echo 'export DOTNET_ROOT=/opt/dotnet' >> ~/.bashrc
fi

echo -e "\e[0m"
echo -e "\e[1m----------------------------------------"
echo -e "\e[1m          Get Blazor Templates"
echo -e "\e[1m----------------------------------------"
echo -e "\e[0m"

dotnet new -i Microsoft.AspNetCore.Components.WebAssembly.Templates::3.2.0

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


