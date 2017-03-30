#!/usr/bin/python
#
# Copyright (C), Attila Sukosd, BIT BLUEPRINT ApS (as@bitblueprint.com)
# 
# The following is a wrapper around airodump-ng to collect information about wireless APs/clients
# http://www.aircrack-ng.org/doku.php?id=airodump-ng
#


import os
import airodump
import signal
import pprint as pp

from time import gmtime, strftime


def signal_handler(signal, frame):
   print ("You pressed CTRL + C!")
   pp.pprint(cl_list)
   
   sys.exit(0)	
   pd.kill()

if __name__ == "__main__":
	signal.signal(signal.SIGINT, signal_handler)

	cl_list = {}
	# Start the airodump-ng processor
	ad = airodump.AirodumpProcessor()
	pd = ad.start()

	starting_time = strftime("Starting dump at %H:%M:%S of %d-%m-%y\n\n", gmtime())
	print starting_time
	while 1:
		try:
			cl_list = ad.process()
		except:
			pass
			
		


	ad.stop()

