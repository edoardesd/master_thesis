#! /bin/bash

mac_address=$1

echo "ping $mac_address"

while : 
	do
		nohup sudo l2ping -f $mac_address
done
