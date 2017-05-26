#!/bin/bash
args=("$@")
for ((i=0; i < $#; i++))
{
    echo "argument $((i+1)): ${args[$i]}"
}