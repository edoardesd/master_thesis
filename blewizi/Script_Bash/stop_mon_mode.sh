#! /bin/bash

dir_up=$2
file_up=$3
iw_name="wlp3s0"
mon_name="mon0"


while [ "$1" != "" ]; do
    case $1 in
        -r | --raspberry )      shift
                               	echo "RaspberryPi mode"
                               	echo
                               	iw_name="wlan1"
								mon_name="wlan1mon"
                                ;;
        
    esac
    shift
done

airmon-ng stop $iw_name && airmon-ng stop $mon_name \
&& service network-manager start

echo "*********** IWCONFIG ***************"

iwconfig
sleep 5
echo "*********** CARICO IL FILE ***************"
bash ./ftp_upload.sh $dir_up $file_up
