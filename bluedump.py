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
		self.bt = subprocess.Popen(['unbuffer', 'log_script/./respawn_l2ping.sh', mac_address], bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.logger = sys.stdout #open("/logs/dump.log", "a")
		#print "Starting at: ", datetime.now().strftime("%H:%M:%S.%f")[:-3]

		return self.bt

	def process(self):

		global mac_address
		CLIENT = mac_address

		if not self.bt:
			self.start()

	
		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()

		if "Ping" in line:
			print "Start pinging process!"
			return self.client_list, True

		if not line:
			print "Finito il tutto"
			return self.client_list, False

		#setto il tempo attuale
		now = datetime.now().strftime("%H:%M:%S.%f")[:-3]

		#chiamo script per recuperare rssi, lq, tpl
		#log_val = subprocess.check_output("log_script/./values_log.sh "+mac_address+" ", shell=True)


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
			print line
			#return self.client_list, False

		if "Recv failed" in line:
			print line
			#return self.client_list, False
		

		#Ping is ok!
		print "Ping in progress!"

		v = re.split(r'\s{1,}', line)
		echo_time = v[-2][:-2]

		if echo_time == ".":
			print "Puntino (no echo time)"
			return self.client_list, True

		
		
		#print "log val e':", log_val
		ck_out_vect = re.split(r'\s{4,}', "3    4    255\n    ")
		#check if device is connected		
		if len(ck_out_vect)<3:
			print "Not Connected!"
			print line
			return self.client_list, True

		
		rssi = ck_out_vect[0]
		lq = ck_out_vect[1]
		if "\n" in ck_out_vect[2]:
			tpl = ck_out_vect[2].replace("\n", "")

		tpl = "3"

		if not self.client_list.has_key(CLIENT):
			self.client_list[CLIENT] = {}

		self.client_list[CLIENT][now] = {"echo_time": echo_time, "rssi": rssi, "lq": lq, "tpl": tpl}

		return self.client_list, True


	def stop(self):
		self.bt.kill()



