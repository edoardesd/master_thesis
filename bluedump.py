#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime
from datetime import datetime




class BluetoothProcessor:

	client_list={}


	def __init__(self): 
		pass

	def start(self):
		outputFile = open("outputFile.txt", "a", 0)
		global mac_address
	
		mac_address = "C8:14:79:31:3C:29"
		self.bt = subprocess.Popen(['unbuffer', './respawn_l2ping.sh', mac_address], bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.bt2 = subprocess.Popen(['ping', '84:11:9E:FD:16:B2'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.logger = sys.stdout #open("/logs/dump.log", "a")
		print "Starting at: ", datetime.utcnow().strftime("%H:%M:%S.%f")[:-3]

		return self.bt

	def process(self):

		global mac_address
		CLIENT = mac_address

		if not self.bt:
			self.start()

	
		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()
		print line

		if "Ping" in line:
			print "Start pinging process!"
			return self.client_list, True

		if not line:
			print "Finito il tutto"
			print line
			return self.client_list, False

		#un po' estremo come metodo
		#if mac_address not in line:
		#	print "No mac address!"
		#	print line
		#	return self.client_list, False

		if "Host is down" in line:
			print "Host is down!!!"
			print line
			return self.client_list, False

		if "Send failed" in line:
			print "Send failed"
			print line
			#return self.client_list, False

		if "Recv failed" in line:
			print "Receive failed"
			print line
			#return self.client_list, False
		

		#Ping is ok!
		print "Ping in process!"

		v = re.split(r'\s{1,}', line)
		echo_time = v[-2][:-2]

		if echo_time == ".":
			print "Puntino (no echo time)"
			return self.client_list, True

		#setto il tempo attuale
		now = datetime.utcnow().strftime("%H:%M:%S.%f")[:-3]

		#chiamo script per recuperare rssi, lq, tpl
		log_val = subprocess.check_output("./values_log.sh "+mac_address+" ", shell=True)
		
		print log_val
		#check if device is connected		
		if "Not connected" in log_val:
			print "Not connected!"
			print line
			return self.client_list, True

		else:
			o = re.split(r'\s{4,}', log_val)
			rssi = o[0]
			lq = o[1]
			if len(o) > 2:
				if "\n" in o[2]:
					tpl = o[2].replace("\n", "")



			if not self.client_list.has_key(CLIENT):
				self.client_list[CLIENT] = {}

			self.client_list[CLIENT][now] = {"echo_time": echo_time, "rssi": rssi, "lq": lq, "tpl": tpl}

		return self.client_list, True


	def stop(self):
		self.bt.kill()



