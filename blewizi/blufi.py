#!/usr/bin/python

import os
import airodump
import hcidump
import bluedump
import signal
import sys
import subprocess
import threading
import csv
import getopt
import copy
import bluetooth
import pprint as pp

from time import strftime, localtime, sleep
from datetime import datetime

############ END OF IMPORT ###############

sleep_time = 60


pwd = subprocess.check_output(['pwd']).rstrip() + "/"

if "master_thesis" not in pwd:
	pwd = pwd + "master_thesis/"
	#''.join([pwd, "/master_thesis/"])

dev = subprocess.check_output(['cat', pwd+'config/raspi-number.txt'])[:1]

mac_address = subprocess.check_output(['cat', pwd+'config/mac-addresses.txt']).split(",")
mac_address[-1] = mac_address[-1].rstrip()


db_table = "debug"

############ THREAD METHODS ##############

class myThread(threading.Thread):
	def __init__(self, threadID, name):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
	def run(self):


		global hc_list
		global wifi_list
		global bd_list
		self.is_scan = True
		print "Start " + self.name + " dump!"
		
		if self.name == "wifi":
			wifi_proc = ad.start(rasp, wifi_string)
		if self.name == "bluetooth":
			bt_proc = bt.start(rasp, bt_dongle)
		if self.name == "ping/rssi":
			bd_proc = bd.start(pwd, mac_address)

		wifi_list, hc_list, bd_list = while_dump(self, self.name)

		print "Exit " + self.name + " dump!"


def while_dump(self, threadName):
	self.is_running = True
	global hc_list
	global wifi_list
	global bd_list

	while self.is_running:
		if threadName == "wifi":
			wifi_list, self.is_running = ad.process(rasp)
		if threadName == "bluetooth":
			hc_list, self.is_running = bt.process(rasp)
		if threadName == "ping/rssi":
			bd_list, self.is_running = bd.process(pwd)

	if not self.is_running:
		if threadName == "wifi":
			ad.stop()
		if threadName == "bluetooth":
			bt.stop()
		if threadName == "ping/rssi":
			bd.stop()


	print "\n\n"
	return wifi_list, hc_list, bd_list

############ END THREAD METHODS ##############







#def signal_handler(signal, frame):
def signal_handler():
	
	print "Program ends at ", datetime.now().strftime("%H:%M:%S")
	subprocess.Popen(['sudo', 'pkill', '-f', pwd+'log_script/scan_python.py'])


	   
############ MAIN ##############
rasp = False
bt_dongle="0"

try:
	opts, args = getopt.getopt(sys.argv[1:], 'r:d:t:n:h', ['raspi-mode=', 'device=', 'time=', 'name=' , 'help'])
except getopt.GetoptError:
	#usage()
	print "TODO how to use"
	sys.exit(2)

for opt, arg in opts:
	if opt in ('-h', '--help'):
		print "TODO how to use"
		#usage()
		sys.exit(2)
	elif opt in ('-r', '--raspi-mode'):
		rasp = True
	elif opt in ('-d', '--device'):
		dev = arg
	elif opt in ('-n', '--name'):
		db_table = arg
	elif opt in ('-t', '--time'):
		sleep_time = float(arg)
	else:
		#usage()
		print "TODO how to use"
		sys.exit(2)

if __name__ == "__main__":
	#signal.signal(signal.SIGINT, signal_handler)

	wifi_list = {}
	hc_list = {}
	bd_list = {}

 	subprocess.Popen(['sudo', 'hcitool', 'spinq'])
	
	# Start the airodump-ng processor
	ad = airodump.AirodumpProcessor()

	#Start the hcidump processor
	bt = hcidump.HcidumpProcessor()

	#Start the bluedump processor
	bd = bluedump.BluetoothProcessor()


	starting_time = strftime("%H%M%S", localtime())
	starting_day = strftime("%d%m%y", localtime())
	starting_string = " starts at " +starting_time+ "  of " +starting_day

	wifi_string = "wifiraw_"+starting_day+"_"+starting_time
	print "BLEWIZIrid sdump V 3.0", starting_string

	#if dev == "1":
	#	print "Start MYSQL"
	#	mysql_connector()
	
	#subprocess.call([pwd+'Script_Bash/./wifi_py_config.sh'], shell=True)

	thread_wifi = myThread(1, "wifi")
	thread_hc = myThread(2, "bluetooth")
	#thread_bd = myThread(3, "ping/rssi")



	#thread_bd.start()
	thread_hc.start()
	thread_wifi.start()	
	
	
	sleep(sleep_time)
	print "\nStop, going to sleep"

	ad.stop()
	bt.stop()
	#bd.stop()
	signal_handler()
