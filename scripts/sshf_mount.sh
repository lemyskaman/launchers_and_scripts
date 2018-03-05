#! /bin/sh
#    by lemys lopez lemyskaman@gmail.com


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

PASSWORD=$( zenity --password --title="$USER@$HOST ")
echo $PASSWORD

zenity --notification --text="atempting to mount on $MOUNT_POINT_DIR"


mount () {

echo $PASSWORD  | sshfs -p$PORT $USER@$HOST:$TARGET_DIR $MOUNT_POINT_DIR -o   password_stdin -o auto_unmount -o nonempty 
MOUNT_STATUS=$?

}

if [ -d "$MOUNT_POINT_DIR" ]; 
	then
 		mount
		if [ $MOUNT_STATUS -gt 0 ]
			then 
				zenity --error --text="ERROR MOUNTING ON $MOUNT_POINT_DIR" 
			else
				zenity --notification --text="SUCCESS MOUNT ON $MOUNT_POINT_DIR"
		fi
	else
		zenity --error --text="CANT MOUNT ON $MOUNT_POINT_DIR directory does not exists"
		
fi


#HOST=
#PORT=2222
#USER=kaman
#PASS="128162(("
#REMOTE_DIR=/
#LOCAL_DIR="/kaman_host"

#echo $PASS  |  sshfs -p$PORT $USER@$HOST:$REMOTE_DIR $LOCAL_DIR -o   password_stdin -o auto_unmount -o nonempty

