#! /bin/bash

iw_name="wlan1"



ifconfig $iw_name up  \
&& airmon-ng start $iw_name

echo "monitor mode enabled"