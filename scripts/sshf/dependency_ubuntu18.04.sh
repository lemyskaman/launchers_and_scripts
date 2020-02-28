#!/bin/bash 
# author: lemys lopez
# mail: lemyskaman@gmail.com
# description: install all ubuntu 18.04 dependcyes and  sshf_mount script to work on your distro 

clear
#echo "installing dependcyes"
#sudo apt-get install ssh fuse sshfs zenity sshpass
#echo "giving executable permisions on sshf_mount"
#sudo chmod +x sshf_mount
echo "atemping to creating sshf_mount softlink on /usr/bin"

FILE="/usr/bin/sshf_mount"
if [ - "$FILE" ]; then
    echo "the softlink already exists"
else 
	sudo ln -s sshf_mount $FILE
fi
echo "atemping to create the main folder were to mount remote directories at ~/sshf_mount_computers"
FILE="/home/kaman/sshf_mount_computers"
if [ -d "$FILE" ]; then
    echo "the folder $FILE already exists"
else 
	mkdir $FILE
fi
