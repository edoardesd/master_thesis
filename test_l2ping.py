#!/usr/bin/python

import subprocess
import os
import sys
import shlex

#address = "C8:14:79:31:3C:29"
#res = subprocess.Popen(['l2ping', address], stderr=subprocess.PIPE, stdout=subprocess.PIPE)

#output=res.communicate()[0]

#print output

cmd = "sudo l2ping -c 4 C8:14:79:31:3C:29"

def run_command(command):
    process = subprocess.Popen(shlex.split(command), stdout=subprocess.PIPE)
    while True:
        output = process.stdout.readline()
        if output == '' and process.poll() is not None:
            break
        if output:
            print output.strip()
    rc = process.poll()
    return rc


run_command(cmd)