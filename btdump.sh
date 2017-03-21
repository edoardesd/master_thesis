#! /bin/bash


trap ctrl_c INT

function ctrl_c(){
	echo "Stop capturing probes from bluetooth and BLE"
	sh ./ftp_upload.sh $data_day/bluetooth $hcifile

}


data=$(date +"%y%d%m-%H%M")

data_day=$(date +"%y%m%d")

mkdir -p $data_day/bluetooth

hcifile="hci-$data.txt"

hcidump -t | tee "$data_day/bluetooth/$hcifile"