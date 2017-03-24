#! /bin/bash


trap ctrl_c EXIT

function ctrl_c(){
	echo "Stop capture probes from bluetooth and BLE"
	sh ./ftp_upload.sh $data_day/bluetooth $hcifile
}
################## VARS DECL AND INIT ##############
echo Start bluetooth DUMP


data=$(date +"%y%d%m-%H%M")

data_day=$(date +"%y%m%d")

hcifile="BT-$data.txt"


################### END VAR DECL ##############

mkdir -p $data_day/bluetooth

###### HCI DUMP ######
hcidump -at | tee -a "$data_day/bluetooth/$hcifile"
####### END #######