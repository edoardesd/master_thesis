#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime
from datetime import datetime


global counter
global ping


class BluetoothProcessor:

	global counter
	client_list={}


	def __init__(self): 
		pass

	def start(self, pwd, mac_list):
		#global mac_address
		global counter
		counter = 0
		global ping
		ping = 0
		
		if ping:
			self.bt = subprocess.Popen(['unbuffer', pwd+'Script_Bash/./multiple_ping.sh'] + mac_list, bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		else: self.bt = subprocess.Popen(['unbuffer', pwd+'Script_Bash/./con_bluetooth.sh'] + mac_list, bufsize=0, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.logger = sys.stdout #open("/logs/dump.log", "a")
		#print "Starting at: ", datetime.now().strftime("%H:%M:%S.%f")[:-3]

		return self.bt

	def process(self, pwd):
		global counter
		global ping
		#global mac_address
		#CLIENT = mac_address

		if not self.bt:
			self.start()

	
		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()


		now = datetime.now().strftime("%H:%M:%S")
		
		global ping
		if ping:
			if "Ping" in line:
				print "Start pinging process!"
				return self.client_list, True

			#killare bene le cose
			if not line:
				#print "Finito il tutto"
				return self.client_list, False

			#setto il tempo attuale
			
			#now = datetime.now().strftime("%H:%M:%S.%f")[:-3]


			#un po' estremo come metodo
			#if mac_address not in line:
			#	print "No mac address!"
			#	print line
			#	return self.client_list, False

			if "Host is down" in line:
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
			if (counter % 17 == 0):
				print "Ping in progress!"

			v = re.split(r'\s{1,}', line)
			
			if len(v)>3:
				CLIENT = v[3]
			else: 
				return self.client_list, True

			if CLIENT is not None or CLIENT is not '':
				if CLIENT.count(":")>3:
				#chiamo script per recuperare rssi, 
					log_val = subprocess.check_output([pwd+'log_script/./values_log.sh', CLIENT])
				else: 
					print "Not a mac address ", line
					return self.client_list, True
			else: 
				print "Client null: ", line
				return self.client_list, True

			echo_time = v[-2][:-2]

			if echo_time == ".":
				print "Puntino (no echo time)"
				return self.client_list, True

			if ":" in echo_time:
				print "mac address in echo ", line
				return self.client_list, True

			
			#print "log val e':", log_val
			ck_out_vect = re.split(r'\s{4,}', log_val)
			#check if device is connected		
			if len(ck_out_vect)<1:
				print "Not Connected!"
				print line
				return self.client_list, True

			
			rssi = ck_out_vect[0].replace("\n", "")
			#lq = ck_out_vect[1]
			#if "\n" in ck_out_vect[2]:
			#	tpl = ck_out_vect[2].replace("\n", "")


			if "Usage" in rssi:
				return self.client_list, True


			if not self.client_list.has_key(CLIENT):
				self.client_list[CLIENT] = {}

			self.client_list[CLIENT][now] = {"echo_time": echo_time, "rssi": rssi}

		else:

			#global counter
			counter += 1
			if (counter % 17 == 0):
				print "Connection in progress!"

			if not line:
				print "not"
				#print "Finito il tutto"
				return self.client_list, False

			if "Can't" in line:
				return self.client_list, True
			
			if "Starting" in line:
				return self.client_list, True

			


			v = re.split(r'\s{1,}', line)
			
			if len(v)>2:
				CLIENT = v[2]
			else: 
				return self.client_list, True

			if CLIENT is not None or CLIENT is not '':
				if CLIENT.count(":")>3:
				#chiamo script per recuperare rssi, 
					log_val = subprocess.check_output([pwd+'log_script/./values_log.sh', CLIENT])
				else: 
					print "Not a mac address ", line
					return self.client_list, True
			else: 
				print "Client null: ", line
				return self.client_list, True

			ck_out_vect = re.split(r'\s{4,}', log_val)
			#check if device is connected		
			if len(ck_out_vect)<1:
				print "Not Connected!"
				print line
				return self.client_list, True

			
			rssi = ck_out_vect[0].replace("\n", "")
			#lq = ck_out_vect[1]
			#if "\n" in ck_out_vect[2]:
			#	tpl = ck_out_vect[2].replace("\n", "")


			if "Usage" in rssi:
				return self.client_list, True

			if rssi == '':
				return self.client_list, True


			if not self.client_list.has_key(CLIENT):
				self.client_list[CLIENT] = {}

			self.client_list[CLIENT][now] = {"rssi": rssi}
			


		return self.client_list, True


	def stop(self):
		#subprocess.Popen(['sudo','killall','l2ping'])
		self.bt.kill()



