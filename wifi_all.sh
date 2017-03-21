#! /bin/bash

trap ctrl_c INT

function ctrl_c(){
	echo "Stop capturing probes from wifi"
	sh ./stop_mon_mode.sh $data_day/wifi $wifi_file-01.csv

}

iw_name="wlp3s0"
iw_mon_name="mon0"

data_day=$(date +"%y%m%d")

mkdir -p $data_day/wifi

data_time=$(date +"%y-%d-%m-%H%M")
wifi_file="wifi-$data_time"


ifconfig $iw_name up  \
&& airmon-ng check kill \
&& airmon-ng start $iw_name \
&& airodump-ng $iw_mon_name -w $data_day/wifi/$wifi_file --output-format csv

