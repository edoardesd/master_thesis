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

		return self.bt

	def process(self):
		global mac_address

		CLIENT = mac_address

		if not self.bt:
			self.start()

		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()
		#line2 = self.bt2.stdout.readline()
		
		#setto il tempo attuale
		now = datetime.utcnow().strftime("%H:%M:%S.%f")[:-3]

		#per guardare output di airodump a schermo
		#if line:
			#self.logger.write("L:"+line.encode('ascii', errors='ignore'))
		
		if not line:
			return self.client_list, False
		
		if mac_address not in line:
			return self.client_list, True

		v = re.split(r'\s{1,}', line)
		echo_time = v[-2][:-2]

		if echo_time == ".":
			print echo_time
			return self.client_list, True

		print echo_time

		if not self.client_list.has_key(CLIENT):
			self.client_list[CLIENT] = {}
			self.client_list[CLIENT]["ping"] = {now: {"echo_time": echo_time}}

		
		self.client_list[CLIENT]["ping"][now] = {"echo_time": echo_time} 


		log_val = subprocess.check_output("./values_log.sh "+mac_address+" ", shell=True)
	

		o = re.split(r'\s{4,}', log_val)
		print o
		self.client_list[CLIENT]["log"] = {now: {"rssi": o[0]}}

		return self.client_list, True


	def stop(self):
		self.bt.kill()



