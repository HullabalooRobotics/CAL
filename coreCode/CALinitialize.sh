#!/bin/bash

# --- Testing to see if the settings override file exists ---
cd /home/pi/CAL/config/
FILE=overrides.cfg
if test -f "$FILE"; 
then
    printf "\n"
else
    FILE=settings.txt
fi
#-----------------------------------------------------------

#---------- Making all relavent variables ------------------
cd /home/pi/CAL/config
authCode=$(sed -n '4p' < $FILE)
authCode=${authCode:9}
blynkActivationState=$(sed -n '2p' < $FILE)
lightshowActivationState=$(sed -n '3p' < $FILE)
blynkActivationState=${blynkActivationState:9}
lightshowActivationState=${lightshowActivationState:13}
activateAutoUpdate=$(sed -n '13p' < $FILE)
activateAutoUpdate=${activateAutoUpdate:11}
#-------------------------------------------------------------

#---------------------- Logo ---------------------------------
clear
cd
echo "     _______   ___   ___               "
echo "    /  ____/  / _ \  \  \              "
echo "   /  /      / /_\ \  \  \             "
echo "  /  /___   /  / \  \  \  \___         "
echo " /______/  /__/   \__\  \_____\   V.6  "
echo " "
#echo " "
#------------------------------------------------------------

#------------------Getting Rid of Spaces---------------------
cd /home/pi/CAL/Music
#echo " "
#echo "Getting rid of spaces"
echo -ne '                     (0%) Getting rid of spaces           \r'
sleep 1
find . -depth -name '* *' \
| while IFS= read -r f ; do mv -i "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done
cd
#-----------------------------------------------------------

#----------Mount USB Device (If Needed) -----------
#echo "Mounting USB...
#sudo mount /dev/sda1 usbDevice
#echo " "
#--------------------------------------------------

#--------Make Playlist from Songs------------------
echo -ne '####               (20%) Making playlist from GitHub songs\r'
sleep 1
cd /home/pi/lightshowpi/tools
echo /home/pi/CAL/Music | python /home/pi/lightshowpi/tools/playlist_generator.py &> /dev/null &
echo -ne '########           (40%) Playlist was created             \r'
sleep 1
#-----------------------------------------------------------

#--------Kill All Blynk Scripts--------------------
sudo killall blynk
sleep 1
#------------------------------------------------

#-------    Active Auto-Update  ------------------
#printf "Auto update is: %s\n" $activateAutoUpdate
if [ $activateAutoUpdate = "on" ] || [ $activateAutoUpdate = "On" ]
then
	echo -ne '############    (50%) Activating Auto Update           \r'
	cd /home/pi/CAL/coreCode/
	python autoUpdate.py >/dev/null 2>&1 &
	sleep 1
else
	echo -ne '############    (50%) Deactivating Auto Update           \r'
	cd /home/pi/CAL/coreCode/
	pkill -f autoUpdate.py >/dev/null 2>&1 &
	sleep 1
fi
#----------------------------------------------------

#------------Activate Blynk-----------------------
if [ $blynkActivationState = "true" ] || [ $blynkActivationState = "True" ]
then
	#echo "Running Blynk for this unit. Please change Auth code if CAL installed on new unit"
	echo -ne '############    (60%) Running Blynk                    \r'
	cd /home/pi/blynk-library/linux/ && sudo ./blynk --token=$authCode &> /dev/null &
	sleep 1
fi
echo -ne '################(100%) Complete                               \r\n'
echo "You're all ready to go!"
exit
#-------------------------------------------------------------

