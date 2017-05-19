#!/bin/bash

mac_addr=$1

trap ctrl_c EXIT

function ctrl_c(){
	echo "Stop l2ping!"
	check="0"
	sudo killall l2ping

}



until l2ping $mac_addr; do
   echo "l2ping failed. Exit code $?.  Respawning on $mac_addr.." >&2
   sleep 1
done

