#!/bin/bash

ARRAY_MAC=("$@")

pos=$(( ${#ARRAY_MAC[*]} - 1 ))
last=${ARRAY_MAC[$pos]}



for mac in ${ARRAY_MAC[*]}
do
	if [[ $mac == $last ]]
	then 
		until l2ping $mac; do 
			echo "rientro di la"
			sleep 1
		done
		break
	fi


	until l2ping $mac; do 
		echo "rientro"
		sleep 1
	done &

done


#until l2ping C8:14:79:31:3c:29; do 
#	echo "rientro"
#	sleep 1
#done & until l2ping 88:C9:D0:1F:3E:48; do
#	echo "rientro dall'altro"
#	sleep 1
#done & until l2ping 00:02:72:CE:04:71; do
#	echo "rientro da dikom"
#	sleep 1
#done 

