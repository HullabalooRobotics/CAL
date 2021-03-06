#!/bin/bash

#build script for the CAL libraries (Blynk and LightShowPi)
echo "Are you sure you'd like to install CAL, which "
echo  "will also install Blynk, LightShowPi, and WiringPi"
echo -n "repositories? (y/n)"
read answer

if echo "$answer" | grep -iq "^y" ;then
    echo "Good choice! The install will being shortly"
	cd /home/pi/CAL/config/

	FILE=overrides.cfg
	if test -f "$FILE"; 
	then
    	printf "$FILE exist. No need to copy\n"
	else
    	printf "$FILE doesn't exist. Duplicating defaults\n"
    	cp settings.txt overrides.cfg
	fi

    sleep 1
	cd /home/pi/
	sudo apt-get update && sudo apt-get upgrade
	
if [ ! -d "$blynk-library" ]; then
	#BLYNK Install
	echo "Installing Blynk"
	echo -ne '                          (00%)\r'
	git clone https://github.com/blynkkk/blynk-library.git
	cd /home/pi/blynk-library/
	git checkout dab48f7c89f3eb7d8a6c09a0b4137813644b6817
	sleep 1
	echo -ne '#############              (50%)\r'
	cd /home/pi/blynk-library/linux
	make clean all target=raspberry
	echo "type this to run blynk: sudo ./blynk --token=YourAuthToken"
	sleep 3
	echo -ne '#######################   (100%)\r'
	echo -ne '\n'
	echo "Blynk Installed"
	sleep 1
fi

if [ ! -d "$lightshowpi" ]; then
	#Lightshowpi Installing
	sudo apt-get install python-mutagen python3-mutagen
	cd /home/pi/
	echo -ne '##                          (12%)\r'
	echo "Installing LightshowPi"
	# Install git (if you don't already have it)
	sudo apt-get install git-core
	# Clone the repository to /home/pi/lightshowpi
	sleep 1
	git clone https://togiles@bitbucket.org/togiles/lightshowpi.git
	echo -ne '#############              (50%)\r'
	# Grab the stable branch
	cd lightshowpi
	sleep 1
	git fetch && git checkout stable
	cd /home/pi/lightshowpi
	sudo apt-get remove python-mutagen
	sudo ./install.sh
	echo -ne '#############              (100%)\r'
fi	
	cd
	sudo apt-get install w3m
	sudo pip install sh
	sudo pip install geocoder
	echo "Completed. Please reboot with 'sudo reboot' "
	echo "Thank you for using the CAL Smart Outlet Library"

else
    echo "Okay, maybe next time"
	#sleep 1
fi

exit
