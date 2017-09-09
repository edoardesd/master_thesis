#!/bin/bash

ARRAY_MAC=("$@")
#mac=$1
#pos=$(( ${#ARRAY_MAC[*]} - 1 ))
#last=${ARRAY_MAC[$pos]}


echo "Starting connection script"

while true; do
	for mac in ${ARRAY_MAC[*]}
	do
	
		if [[ $(sudo hcitool con | grep $mac) ]]; then
			echo "Already connected $mac"
		else
			sudo hcitool cc $mac
			echo "Connection established $mac"
		fi
		#sleep 0.5
	done
done