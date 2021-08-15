#!/bin/bash

echo -e "\n----------------------------------------"
echo -e "\n       Dot Net Core Installer"
echo -e "\n----------------------------------------"
echo ""
echo -e "\nPete Codes / PJG Creations 2020"
echo ""
echo -e "Latest update 12/05/2021"
echo ""
echo "This will install the following;"
echo ""
echo -e "\n----------------------------------------"
echo -e "\n"
echo "- Dot Net Core LTS"
echo "- ASP.NET Core LTS"
echo ""
echo -e "\n----------------------------------------"
echo -e "\n"
echo -e "Any suggestions or questions, email \e[1;4mpete@pjgcreations.co.uk"
echo -e "\nSend me a tweet @pete_codes"
echo -e "\nTutorials on https://www.petecodes.co.uk"
echo ""
echo -e "\n----------------------------------------"
echo -e "\n"

if [[ "${EUID}" = 0 ]]; then
    while true; do
        read -p "Already sudo, do you really want to run the whole script as root?" yn
        case $yn in
	    y|Y|yes|Yes)
                break
		;;
	    n|N|no|No)
		echo "Okay, exiting now, rerun the script without sudo"
		exit 1
		;;
	    *)
	        echo "Default is to exit the script if run as sudo"
		exit 1
		;;
	esac
    done
else
    echo "Requesting sudo now, you may be asked for a password"
    while true; do
        sudo -k
        if sudo false; then
	    echo "You may have entered the wrong password, please try again or you can break out of this with Ctrl+c"
	else
	    break
	fi
    done
    echo "sudo acquired"
fi

install_version=""
case $arg2 in
    current)
        install_version="-c Current"
	;;
    *)
	install_version=""
	;;
esac

echo "Getting MS dotnet install script"
cd ~/
wget https://dot.net/v1/dotnet-install.sh
chmod u+x dotnet-install.sh

echo -e "\n"
echo -e "\n----------------------------------------"
echo -e "\n     Installing Dot Net Core Binaries"
echo -e "\n----------------------------------------"
echo -e "\n"

./dotnet-install.sh $install_version

echo -e "\n"
echo -e "\n----------------------------------------"
echo -e "\n       Getting ASP.NET Core Runtime"
echo -e "\n----------------------------------------"
echo -e "\n"

./dotnet-install.sh $install_version --runtime aspnetcore


if grep -q 'export DOTNET_ROOT=' ~/.bashrc;  then
  echo 'Already added link to .bashrc'
else
  echo 'Adding Link to .bashrc'
  echo 'export DOTNET_ROOT=~/.dotnet' >> ~/.bashrc
fi

#echo -e "\e[0m"
#echo -e "\e[1m----------------------------------------"
#echo -e "\e[1m   Blazor Templates are now included!"
#echo -e "\e[1m----------------------------------------"
#echo -e "\e[0m"

#dotnet new -i Microsoft.AspNetCore.Components.WebAssembly.Templates::3.2.1

echo -e "\n"
echo -e "\n----------------------------------------"
echo -e "\n          Run dotnet --info"
echo -e "\n----------------------------------------"
echo -e "\n"

source ~/.bashrc
dotnet --info

echo -e "\n"
echo -e "\n----------------------------------------"
echo -e "\n              ALL DONE!"
echo ""
echo -e "\nGo ahead and run dotnet new console in a new directory!"
echo ""
echo ""
echo -e "Let me know how you get on by tweeting me at @pete_codes"
echo ""
echo -e "\n----------------------------------------"
echo -e "\n"
