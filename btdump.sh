#! /bin/bash


trap ctrl_c INT

function ctrl_c(){
	kill $dump_pid
	echo "Stop capturing probes from bluetooth and BLE"
	sh ./ftp_upload.sh $data_day/bluetooth $hcifile
	kill $my_pid
}
################## VARS DECL AND INIT ##############
my_pid=$$

data=$(date +"%y%d%m-%H%M")

data_day=$(date +"%y%m%d")

hcifile="BT-$data.txt"


################### END VAR DECL ##############
echo Il mio pid è $my_pid

mkdir -p $data_day/bluetooth

###### WHILE BEGIN ######
while :
do
	hcidump -at | tee -a "$data_day/bluetooth/$hcifile" &
	dump_pid=$!
	echo pid del figlio è $dump_pid

	sleep 1800
	kill $dump_pid
	echo ho killato $dump_pid
	sleep 3

done
####### WHILE END #######