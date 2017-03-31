#!/usr/bin/python

import os
import airodump
import signal
import sys
import pprint as pp

from time import gmtime, strftime


def signal_handler(signal, frame):
   print ("You pressed CTRL + C!")
   pp.pprint(cl_list)
   
   sys.exit(0)	
   proc.kill()



################# MAIN START ##################
rasp = False

if len(sys.argv) > 1:
	if sys.argv[1] == "-r":
		print "Rasperry Pi mode activated!\n\n"
		rasp = True


if __name__ == "__main__":
	signal.signal(signal.SIGINT, signal_handler)

	cl_list = {}
	# Start the airodump-ng processor
	ad = airodump.AirodumpProcessor()
	proc = ad.start(rasp)

	starting_time = strftime("Starting dump at %H:%M:%S of %d-%m-%y\n\n", gmtime())
	print starting_time
	while 1:
		try:
			cl_list = ad.process()
		except:
			pass
			


	ad.stop()

