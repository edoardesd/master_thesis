#! /bin/bash

data=$(date +"%y%d%m-%H%M")

hcifile="hci-$data.txt"

hcidump -t | tee "$hcifile"

trap SIGINT