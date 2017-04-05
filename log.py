#!/usr/bin/python

import os
import airodump
import hcidump
import signal
import sys
import subprocess
import threading
import pprint as pp

from time import strftime, localtime


class myThread(threading.Thread):
	def __init__(self, threadID, name):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
	def run(self):

		global bt_list
		global cl_list

		print "Starting " + self.name + " dump!"
		if self.name == "wifi":
			wifi_proc = ad.start(rasp)
		if self.name == "bluetooth":
			bt_proc = bt.start(rasp)

		cl_list, bt_list = while_dump(self.name)

		print "Exiting " + self.name + " dump!"


def while_dump(threadName):
	is_running = True
	global bt_list
	global cl_list
	while is_running:
		if threadName == "wifi":
			cl_list, is_running = ad.process(rasp)
		if threadName == "bluetooth":
			bt_list, is_running = bt.process(rasp)

	if not is_running:
		if threadName == "wifi":
			ad.stop()
		if threadName == "bluetooth":
			bt.stop()


	print "\n\n"
	return cl_list, bt_list

def signal_handler(signal, frame):
	print ("You pressed CTRL + C!\n\n")
	print "WIFI DEVICES:"
	pp.pprint(cl_list)
	print "BLUETOOTH DEVICES:"
	pp.pprint(bt_list)
	
	#sys.exit(0)	



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

	starting_time = strftime("BLEWIZI dump V0.2. Start at time %H:%M:%S of %d-%m-%y\n", localtime())
	print starting_time
	
	thread_wifi = myThread(1, "wifi")
	thread_bt = myThread(2, "bluetooth")

	thread_wifi.start()
	thread_bt.start()