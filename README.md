# CAL 
"CAL" stands for Computer Automated Lighting (Using Blynk and LightshowPi). The hope is to allow people of varying ages to get into Christmas lightshows, as well as home automation. 

## Parts of the CAL repo:
	Blynk
	Lightshowpi

![alt text](https://lh6.googleusercontent.com/ctYdGtYszsb3DZviTlMt2oIX_8KckbdP6get4y7c1AtzgQQgmFPM3zz5PCl-ixKv8BJNRM3BkRYBVkoet1LVjZ-XGqtB--tqVUN0r0Fhiv60Qh9Ai9c=w371)


###Thing to Consider

##Add to end of .bashrc

cd /home/pi/CAL/coreCode/ && sudo ./myStartingScript &

##Add to Crontab

First, type the following:

crontab -e

The second option is often the easiest to work with. Below is the code required to copy/paste. Remember to change the directory/file name to properly address your hardware version:

0 18 * * * cd /home/pi/CAL/examples/CAL_JUNIOR/ && ./allCalJuniorPinsOn.sh && cd >/dev/null 2>&1
0 22 * * * cd /home/pi/CAL/examples/CAL_JUNIOR/ && ./allCalJuniorPinsOff.sh && cd >/dev/null 2>&1
