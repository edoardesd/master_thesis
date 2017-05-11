#! /bin/bash

MAC=$1
remove_rssi="RSSI return value: "
remove_lq="Link quality: "
remove_tpl="Current transmit power level: "

OUT_rssi="$(sudo hcitool rssi $MAC)"
OUT_lq="$(sudo hcitool lq $MAC)"
OUT_tpl="$(sudo hcitool tpl $MAC)"
RSSI_val=${OUT_rssi#$remove_rssi}
LQ_val=${OUT_lq#$remove_lq}
TPL_val=${OUT_tpl#$remove_tpl}
	
echo "$RSSI_val    $LQ_val    $TPL_val"

