#! /bin/bash

MAC=$1
remove="RSSI return value: "
sum_rssi=0
x=0


while true; do
	((x++))
	OUT="$(sudo hcitool rssi $MAC)"
	RSSI_val=${OUT#$remove}
	sum_rssi=$((sum_rssi+RSSI_val))
	echo $((100*sum_rssi/x)) | sed 's/..$/.&/'
	echo "rssi: $RSSI_val  ----- avg rssi: $avg "
done

