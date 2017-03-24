#! /bin/bash

file_up=$2
dir_up=$1
iw_name="wlp3s0"

airmon-ng stop $iw_name && airmon-ng stop mon0 \
&& service network-manager start

echo "*********** IWCONFIG ***************"

iwconfig
sleep 5
echo "*********** CARICO IL FILE ***************"
bash ./ftp_upload.sh $dir_up $file_up
