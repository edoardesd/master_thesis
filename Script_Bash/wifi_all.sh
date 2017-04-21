#! /bin/bash

trap ctrl_c EXIT

function ctrl_c(){
	echo "Stop capture probes from wifi"
	sh ./stop_mon_mode.sh $mode $data_day/wifi $wifi_file-01.csv

}

iw_name="wlp3s0"
iw_mon_name="mon0"
mode=""


while [ "$1" != "" ]; do
    case $1 in
        -r | --raspberry )      shift
                               	echo "RaspberryPi mode activated"
                               	echo
                               	iw_name="wlan1"
								iw_mon_name="wlan1mon"
								mode="-r"
                                ;;
        -h | --help )           
								echo "help not implemented yet ;)"
                                exit
                                ;;
        
    esac
    shift
done




data_day=$(date +"%y%m%d")

mkdir -p $data_day/wifi

data_time=$(date +"%y-%d-%m-%H%M")
wifi_file="wifi-$data_time"


ifconfig $iw_name up  \
&& airmon-ng check kill \
&& airmon-ng start $iw_name
airodump-ng $iw_mon_name -w $data_day/wifi/$wifi_file --output-format csv