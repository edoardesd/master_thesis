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
		global mac_address
		mac_address = "C8:14:79:31:3C:29"
		self.bt = subprocess.Popen(['l2ping', mac_address], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.bt2 = subprocess.Popen(['ping', '84:11:9E:FD:16:B2'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")
		print "Starting at: ", datetime.utcnow().strftime("%H:%M:%S.%f")[:-3]
		return self.bt

	def process(self):
		global mac_address

		CLIENT = mac_address

		if not self.bt:
			self.start()

		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()
		
		#setto il tempo attuale
		now = datetime.utcnow().strftime("%H:%M:%S.%f")[:-3]

		#chiamo script per recuperare rssi, lq, tpl
		log_val = subprocess.check_output("./values_log.sh "+mac_address+" ", shell=True)
		if "Not" in log_val:
			print "not connected at ", now
		
		else:
			o = re.split(r'\s{4,}', log_val)
			rssi = o[0]
			lq = o[1]
			tpl = o[2].replace("\n", "")

		if not line:
			return self.client_list, False

		if "Send failed" in line:
			return self.client_list, False
		
		if mac_address not in line:
			print "not mac at ", now
			return self.client_list, True

		v = re.split(r'\s{1,}', line)
		echo_time = v[-2][:-2]

		if echo_time == ".":
			print "not puntino at ", now
			return self.client_list, True

		if not self.client_list.has_key(CLIENT):
			self.client_list[CLIENT] = {}

		self.client_list[CLIENT][now] = {"echo_time": echo_time, "rssi": rssi, "lq": lq, "tpl": tpl}

		return self.client_list, True


	def stop(self):
		self.bt.kill()



