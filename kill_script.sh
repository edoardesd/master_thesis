#! /bin/bash

echo "Waiting for kill"
sleep 20
echo "Ti killo ;)"

killall -SIGINT airodump-ng
killall -SIGINT hcidump