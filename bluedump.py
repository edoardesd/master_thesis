#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime
from datetime import datetime


global counter


class BluetoothProcessor:

	global counter
	client_list={}


	def __init__(self): 
		pass

	def start(self):
		#global mac_address
		global counter
		counter = 0
	
		mac_address = "C8:14:79:31:3c:29"
		#self.bt = subprocess.Popen(['unbuffer', 'log_script/./respawn_l2ping.sh', mac_address], bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.bt = subprocess.Popen(['unbuffer', 'Script_Bash/./multiple_ping.sh'], bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.logger = sys.stdout #open("/logs/dump.log", "a")
		#print "Starting at: ", datetime.now().strftime("%H:%M:%S.%f")[:-3]

		return self.bt

	def process(self):
		global counter
		#global mac_address
		#CLIENT = mac_address

		if not self.bt:
			self.start()

	
		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()

		if "Ping" in line:
			print "Start pinging process!"
			return self.client_list, True

		#killare bene le cose
		if not line:
			print "Finito il tutto"
			return self.client_list, False

		#setto il tempo attuale
		now = datetime.now().strftime("%H:%M:%S.%f")[:-3]

		

		#un po' estremo come metodo
		#if mac_address not in line:
		#	print "No mac address!"
		#	print line
		#	return self.client_list, False

		if "Host is down" in line:
			print "Host is down!!!"
			print line
			return self.client_list, True

		if "Send failed" in line:
			print line
			return self.client_list, True

		if "Recv failed" in line:
			print line
			return self.client_list, True
		
		if "no response" in line:
			print "No response!"
			return self.client_list, True

		if "l2ping" in line:
			print "Respawn l2ping!"
			return self.client_list, True



		#Ping is ok!
		global counter
		counter += 1
		if (counter % 4 == 0):
			print "Ping in progress!"

		v = re.split(r'\s{1,}', line)
		if len(v)>3:
			CLIENT = v[3]
		else: 
			return self.client_list, True

		if CLIENT is not None:
			#chiamo script per recuperare rssi, lq, tpl
			log_val = subprocess.check_output(['log_script/./values_log.sh', CLIENT])
		else: 
			print "Client null: ", line
			return self.client_list, True

		echo_time = v[-2][:-2]

		if echo_time == ".":
			print "Puntino (no echo time)"
			return self.client_list, True

		
		#print "log val e':", log_val
		ck_out_vect = re.split(r'\s{4,}', log_val)
		#check if device is connected		
		if len(ck_out_vect)<3:
			print "Not Connected!"
			print line
			return self.client_list, True

		
		rssi = ck_out_vect[0]
		lq = ck_out_vect[1]
		if "\n" in ck_out_vect[2]:
			tpl = ck_out_vect[2].replace("\n", "")


		if not self.client_list.has_key(CLIENT):
			self.client_list[CLIENT] = {}

		self.client_list[CLIENT][now] = {"echo_time": echo_time, "rssi": rssi, "lq": lq, "tpl": tpl}

		return self.client_list, True


	def stop(self):
		#subprocess.Popen(['sudo','killall','l2ping'])
		self.bt.kill()



