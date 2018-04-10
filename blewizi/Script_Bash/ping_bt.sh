#! /bin/bash

for i in `seq 1 10`;
	do
		sudo l2ping -f F0:F6:1C:87:BB:F4 &
	done 