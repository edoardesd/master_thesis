#!/bin/bash
#how to run with ts
#sudo unbuffer l2ping C8:14:79:31:3c:29 | ./predate.sh > log.txt


while read line ; do
    echo "$(date): ${line}"
done