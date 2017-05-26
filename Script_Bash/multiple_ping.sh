#!/bin/bash

ARRAY_MAC=("$@")

echo ${ARRAY_MAC[*]}


until l2ping C8:14:79:31:3c:29; do 
	echo "rientro"
	sleep 1
done & until l2ping AC:B5:7D:AC:94:71; do
	echo "rientro dall'altro"
	sleep 1
done & until l2ping 00:02:72:CE:04:71; do
	echo "rientro da dikom"
	sleep 1
done 