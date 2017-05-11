#!/usr/bin/python

import os
import airodump
import hcidump
import bluedump
import signal
import sys
import subprocess
import threading
import pprint as pp

from time import strftime, localtime

############ END OF IMPORT ###############

############ THREAD METHODS ##############

class myThread(threading.Thread):
	def __init__(self, threadID, name):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
	def run(self):

		global bt_list
		global wifi_list
		global bd_list

		print "Starting " + self.name + " dump!"
		
		if self.name == "wifi":
			wifi_proc = ad.start(rasp)
		if self.name == "bluetooth":
			bt_proc = bt.start(rasp, bt_dongle)
		if self.name == "ping/rssi":
			bd_proc = bd.start()

		wifi_list, bt_list, bd_list = while_dump(self.name)

		print "Exiting " + self.name + " dump!"

############ END THREAD METHODS ##############

def while_dump(threadName):
	is_running = True
	global bt_list
	global wifi_list
	global bd_list

	while is_running:
		if threadName == "wifi":
			wifi_list, is_running = ad.process(rasp)
		if threadName == "bluetooth":
			bt_list, is_running = bt.process(rasp)
		if threadName == "ping/rssi":
			bd_list, is_running = bd.process()

	if not is_running:
		if threadName == "wifi":
			ad.stop()
		if threadName == "bluetooth":
			bt.stop()
		if threadName == "ping/rssi":
			bd.stop()


	print "\n\n"
	return wifi_list, bt_list, bd_list

def signal_handler(signal, frame):
	print ("You pressed CTRL + C!\n\n")
	print "WIFI DEVICES:"
	pp.pprint(wifi_list)
	print "BLUETOOTH DEVICES:"
	pp.pprint(bt_list)
	print "BLUETOOTH DUMP:"
	pp.pprint(bd_list)
	
	#sys.exit(0)	



############ MAIN ##############
rasp = False
bt_dongle="0"

if len(sys.argv) > 1:
	if sys.argv[1] == "-r":
		print "Rasperry Pi mode activated!\n\n"
		rasp = True
	if sys.argv[1] == "1":
		print "working on dongle 1 (dikom)\n\n"
		bt_dongle = "1"
	else: 
		print "working on dongle 0 (pc)\n\n"
		bt_dongle = "0"

if __name__ == "__main__":
	signal.signal(signal.SIGINT, signal_handler)

	wifi_list = {}
	bt_list = {}
	bd_list = {}
	
	#subprocess.call(['./wifi_py_config.sh'], shell=True)
	#subprocess.call(['hcitool lescan &'], shell=True)
	
	#Start the hcidump processor
	#bt = hcidump.HcidumpProcessor()

	# Start the airodump-ng processor
	#ad = airodump.AirodumpProcessor()

	#Start the bluedump processor
	bd = bluedump.BluetoothProcessor()

	starting_time = strftime("Start at time %H:%M:%S of %d-%m-%y\n", localtime())
	print "BLEWIZI dump V0.5.", starting_time
	
	#thread_wifi = myThread(1, "wifi")
	#thread_bt = myThread(2, "bluetooth")
	thread_bd = myThread(3, "ping/rssi")

	#thread_bt.start()
	#thread_wifi.start()
	thread_bd.start()
	