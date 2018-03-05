#! /bin/sh
#    by lemys lopez lemyskaman@gmail.com

#

#settign the param vars
for i in "$@"
do
case $i in
    -h=*|--host=*)
    HOST="${i#*=}"
    shift # past argument=value
    ;;
    -p=*|--port=*)
    PORT="${i#*=}"
    shift # past argument=value
    ;;
    -u=*|--user=*)
    USER="${i#*=}"
    shift # past argument=value
    ;;
	-t=*|--target=*)
    TARGET_DIR="${i#*=}"
    shift # past argument=value
    ;;
	-m=*|--mount_point=*)
    MOUNT_POINT_DIR="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done



#mount function 
mount_remote () {




if [ -d "$MOUNT_POINT_DIR" ]; 
	then
		PASSWORD=$( zenity --password --title="$USER@$HOST ")

		zenity --notification --text="atempting to mount on $MOUNT_POINT_DIR"

		echo $PASSWORD  | sshfs -p$PORT $USER@$HOST:$TARGET_DIR $MOUNT_POINT_DIR -o   password_stdin -o auto_unmount -o nonempty 
		return $? 				
		
	else
		zenity --error --text="Directory to mount does not exists please run: \n\nmkdir $MOUNT_POINT_DIR"
		return 1
		
fi

}

explorer () {
	caja $MOUNT_POINT_DIR

}

mount | grep $MOUNT_POINT_DIR
MOUNT_STATUS=$?
if [ $MOUNT_STATUS -gt 0 ]
	then 
		mount_remote
		if [ $? -gt 0 ]
			then 
				zenity --error --text="sshfs failed to mount at:\n$MOUNT_POINT_DIR "
			else
				zenity --notification --text="succes mount "
				explorer
		fi
	else
		explorer
fi








