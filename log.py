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
import copy
import pprint as pp

from time import strftime, localtime
from datetime import datetime

############ END OF IMPORT ###############

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

		print "Starting " + self.name + " dump!"
		
		if self.name == "wifi":
			wifi_proc = ad.start(rasp)
		if self.name == "bluetooth":
			bt_proc = bt.start(rasp, bt_dongle)
		if self.name == "ping/rssi":
			bd_proc = bd.start()

		wifi_list, hc_list, bd_list = while_dump(self.name)

		print "Exiting " + self.name + " dump!"


def while_dump(threadName):
	is_running = True
	global hc_list
	global wifi_list
	global bd_list

	while is_running:
		if threadName == "wifi":
			wifi_list, is_running = ad.process(rasp)
		if threadName == "bluetooth":
			hc_list, is_running = bt.process(rasp)
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
	return wifi_list, hc_list, bd_list

############ END THREAD METHODS ##############

############ START CSV METHODS ##############

def init_csv(my_final_list, csv_type):
	if csv_type == "bd":
		data = bd_to_list(my_final_list)
		fieldnames = "timestamp, echo_time, rssi, tpl, lq".split(",")
		path = "dict_output_bd.csv"
	
	if csv_type == "hc":
		data = hc_to_list(my_final_list)
		fieldnames = "mac address, RX, timestamp".split(",")
		path = "dict_output_hcdump.csv"


	csv_list = []
	for values in data:
		inner_dict = dict(zip(fieldnames, values))
		csv_list.append(inner_dict)

	#aggiungere data/orario
	csv_dict_writer(path, fieldnames, csv_list)

def hc_to_list(my_dict):
	final_list = []

	for mac in my_dict:
		my_list = []
		my_list.append(mac)
		if my_dict[mac]["probe info"]:
			for info in my_dict[mac]["probe info"]:
				my_list.append(my_dict[mac]["probe info"][info]["RX"])
				my_list.append(my_dict[mac]["probe info"][info]["TS"])
				final_list.append(copy.deepcopy(my_list))
				my_list.remove(my_dict[mac]["probe info"][info]["RX"])
				my_list.remove(my_dict[mac]["probe info"][info]["TS"])

	return final_list


def bd_to_list(my_dict):
	final_list = []

	for mac in my_dict:
		for ts in my_dict[mac]:
			my_list = []
			my_list.append(ts)
			for val in my_dict[mac][ts]:
				my_list.append(my_dict[mac][ts][val])
			
			final_list.append(my_list)

	return final_list	


def csv_dict_writer(path, fieldnames, data):
	"""
	Writes a CSV file using DictWriter
	"""
	with open(path, "wb") as out_file:
		writer = csv.DictWriter(out_file, delimiter=',', fieldnames=fieldnames)
		writer.writeheader()
		for row in data:
			writer.writerow(row)

############ END CSV METHODS ##############


def signal_handler(signal, frame):
	print "You pressed CTRL + C at", datetime.now().strftime("%H:%M:%S.%f")[:-3], "\n\n"

	print "WIFI DEVICES:"
	pp.pprint(wifi_list)
	print "BLUETOOTH DEVICES:"
	pp.pprint(hc_list)
	print "BLUETOOTH DUMP:"
	pp.pprint(bd_list)
	
	#init_csv(bd_list, "bd")
	#init_csv(hc_list, "hc")
	

	# close file
	#outfile.close()
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
	hc_list = {}
	bd_list = {}
	
	#subprocess.call(['./wifi_py_config.sh'], shell=True)
	#subprocess.call(['hcitool lescan &'], shell=True)
	
	# Start the airodump-ng processor
	ad = airodump.AirodumpProcessor()

	#Start the hcidump processor
	bt = hcidump.HcidumpProcessor()

	#Start the bluedump processor
	bd = bluedump.BluetoothProcessor()

	starting_time = strftime("Start at time %H:%M:%S of %d-%m-%y\n", localtime())
	print "BLEWIZI dump V0.5.", starting_time
	

	thread_wifi = myThread(1, "wifi")

	thread_hc = myThread(2, "bluetooth")
	
	
	#thread_bd = myThread(3, "ping/rssi")

	subprocess.check_output(['hcitool', '-i', 'hci0', 'spinq'])

	thread_hc.start()
	#thread_bd.start()
	thread_wifi.start()
	
	