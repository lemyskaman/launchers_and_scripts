#!/bin/bash

#Author: Lemys Lopez @lemyskaman

#a bash script to toggle vm status 
#will try to start it if it current state is diferent to running


start () {
START_TEXT=$( vboxmanage startvm $1 --type headless )
START_STATUS=$?
if [ $START_STATUS -gt 0 ]
	then

		zenity --error --text="error on $1 vm staring"
		
    else
		zenity --notification --text="$START_TEXT"
		zenity --notification --text="$1 vm was sucssefully started"
		
		
fi
return $START_STATUS
}

save () {
SAVE_TEXT=$( vboxmanage controlvm $1 savestate )
SAVE_STATUS=$?
if [ $SAVE_STATUS -gt 0 ]
	then
		zenity --error --text="error on $1 vm state saving"
		
	else
		zenity --notification --text="Vm $1 state already saved"
fi


return $SAVE_STATUS
}


execute (){
TEST_TEXT=$( vboxmanage showvminfo $1 | grep running )
TEST_STATUS=$?
if [ $TEST_STATUS -gt 0 ]
	then 
		zenity --notification --text="$1 vm is not running, starting it..."
		start $1
	else
		zenity --question --text="$1 vm is running, continue to save it state?"
		if [ $? -gt 0 ]
			then
				zenity --notification --text="$1 $TEST_TEXT"
			else
				zenity --notification --text="Saving $1 vm state..."
				save $1
		fi				
fi

}

#lets check for a valid vm machine
vboxmanage list vms | grep $1
NON_VALID_VM=$?
if [ $NON_VALID_VM -gt 0 ]
	then 
		zenity --error --text="$1 is not a valid vm"
	else
		execute $1
fi



