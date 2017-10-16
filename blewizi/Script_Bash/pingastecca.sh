#! /bin/bash

mac_address=$1

echo $mac_address

while : 
	do
		 sudo l2ping -f $mac_address
done
