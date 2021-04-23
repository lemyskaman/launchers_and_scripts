#!/bin/bash
#by lemys lopez lemyskaman@gmail.com



echo "giving executable permisions on klorchid_boilerplate_set"
sudo chmod +x klorchid_boilerplate_set
CURRENT_PATH=$(pwd -LP)

FILE="/usr/bin/klorchid_boilerplate_set"
if [ -L "$FILE" ]; then
    echo "the softlink already exists"
else 
	sudo ln -s $CURRENT_PATH/klorchid_boilerplate_set $FILE
	if [ $? -gt 0 ]; then 
			echo "Unable to create a softlink at $FILE"	
	else
			echo "klorchid_boilerplate_set successfully installed, you can run now klorchid_boilerplate_set widely on your os"
	fi

fi
