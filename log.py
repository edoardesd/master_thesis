#!/usr/bin/python

import os
import airodump
import hcidump
import signal
import sys
import subprocess
import threading
import pprint as pp

from time import gmtime, strftime


class myThread(threading.Thread):
	def __init__(self, threadID, name):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
	def run(self):
		print "starting " + self.name
		if self.name == "wifi":
			wifi_proc = ad.start(rasp)
		if self.name == "bt":
			bt_proc = bt.start(rasp)
		while_dump(self.name)
		print "exiting " + sefl.name


def while_dump(threadName):
	while 1:
		if threadName == "wifi":
			cl_list = ad.process(rasp)
		if threadName == "bt":
			bt_list = bt.process(rasp)

def signal_handler(signal, frame):
   print ("You pressed CTRL + C!")
   pp.pprint(cl_list)
   pp.pprint(bt_list)
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
	bt_list = {}
	
	
	#Start the hcidump processor
	bt = hcidump.HcidumpProcessor()
	#bt_proc = bt.start(rasp)

	# Start the airodump-ng processor
	ad = airodump.AirodumpProcessor()
	#wifi_proc = ad.start(rasp)

	starting_time = strftime("Starting dump at %H:%M:%S of %d-%m-%y\n\n", gmtime())
	print starting_time
	
	thread_wifi = myThread(1, "wifi")
	thread_bt = myThread(2, "bt")

	thread_wifi.start()
	thread_bt.start()