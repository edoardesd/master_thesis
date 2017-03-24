#!/usr/bin/python

import subprocess
cmd = ["./btdump.sh"]
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
for line in proc.stdout.readlines():
    print line