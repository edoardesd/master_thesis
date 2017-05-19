#!/bin/bash

mac_addr=$1

until l2ping $mac_addr; do
    echo "l2ping failed. Exit code $?.  Respawning on $mac_addr.." >&2
    sleep 1
done