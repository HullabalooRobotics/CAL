#build script for the CAL libraries (Blynk and LightShowPi)
echo -n "Is this a good question (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi
