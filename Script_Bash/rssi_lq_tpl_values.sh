#! /bin/bash

trap ctrl_c SIGINT

function ctrl_c(){
	data_end=$(date +"%y%d%m-%H%M")
	echo "Stop capture at $data_end" 
}

MAC=$1
DEV=$2
remove_rssi="RSSI return value: "
remove_lq="Link quality: "
remove_tpl="Current transmit power level: "
data_start=$(date +"%y%d%m-%H%M")
#sum_rssi=0
#x=0

echo "Start capture at $data_start. MAC address: $MAC	Device: $DEV"

while true; do
	#((x++))
	
	OUT_rssi="$(sudo hcitool -i hci$DEV rssi $MAC)"
	OUT_lq="$(sudo hcitool -i hci$DEV lq $MAC)"
	OUT_tpl="$(sudo hcitool -i hci$DEV tpl $MAC)"
	RSSI_val=${OUT_rssi#$remove_rssi}
	LQ_val=${OUT_lq#$remove_lq}
	TPL_val=${OUT_tpl#$remove_tpl}
	#sum_rssi=$((sum_rssi+RSSI_val))
	
	echo "$RSSI_val		$LQ_val		$TPL_val"
	sleep 1
done
