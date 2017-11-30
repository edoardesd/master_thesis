#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime
from datetime import datetime


class HcidumpProcessor:

	client_list={}

	global in_inquiry
	global in_BLE
	global counter
	counter = 0


	def __init__(self): 
		pass

	def start(self, rasp, my_dongle):

		rasp_mode = False
		if rasp == True:
			rasp_mode = True

		#self.sinq = subprocess.Popen(['hcitool', '-i', 'hci' +my_dongle, 'spinq'])
		#try:
		#	self.blescan = subprocess.call(['hcitool lescan'], shell=True)
		#except:
		#	pass
		self.bt = subprocess.Popen(['hcidump', '-i', 'hci'+my_dongle, '-a'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")

		in_inquiry = False
		in_BLE = False
		
		return self.bt

	def process(self, rasp):
		global in_inquiry
		global in_BLE
		global last_mac
		global counter
		
		mosq_host = "127.0.0.1"
		mosq_topic = "bt/log"

		def mosquitto_pub(my_string):
			print "Sending a message to", mosq_host
			subprocess.call("mosquitto_pub -h "+ mosq_host+" -t "+mosq_topic+" -m \""+my_string+"\"", shell=True)
		


		if not self.bt:
			self.start()

		rasp_mode = False
		if rasp == True:
			rasp_mode = True

		#recupero la stringa che sta scrivendo airodump
		line = self.bt.stdout.readline()
		#print line
		#setto il tempo attuale
		now = datetime.now().strftime("%H:%M:%S")
		#now = datetime.now().strftime("%H:%M:%S.%f")[:-3]

		#per guardare output a schermo
		#if line:
			#elf.logger.write("L:"+line.encode('ascii', errors='ignore'))

		counter +=1
		if (counter%487 == 0):
			print "HCIDUMP is running..."

		if not line:
			#print self.client_list
			return self.client_list, False		

		try:

			if "sniffer - Bluetooth" in line:
				in_inquiry = False
				in_BLE = False
				print "HCIDUMP is running!"

			if "Extended Inquiry" in line:
				in_inquiry = True
				in_BLE = False
			
			if "Inquiry Result with RSSI" in line:
				in_inquiry = True
				in_BLE = False
			
			if "LE Meta Event" in line:
				in_inquiry = False
				in_BLE = True

			#if ("Extended Inquiry" or "Inquiry Result with RSSI") not in line and (line[0] == ">" or line[0] == "<"):
			#	in_inquiry = False
			#	in_BLE = False


			#se sono dentro l'inquiry
			if in_inquiry:
				#elimino la tabbata iniziale
				v = line.replace("    ", "")
				if v.startswith("bdaddr"):
					mac_line = v.split()
					CLIENT = mac_line[1]
					rx_power = mac_line[-1].replace("\n", "")
					last_mac = CLIENT

					if rx_power == '0x0000':
						return self.client_list, True

					#prima volta che scopro il nuovo client
					if not self.client_list.has_key(CLIENT):
						#self.client_list[CLIENT] = {}

						probe_key = 1
						#self.client_list[CLIENT]["times seen"] = 1
						#self.client_list[CLIENT]["probe info"] = {probe_key: {"RX": rx_power, "TS": now}}
						#self.client_list[CLIENT]["first seen"] = now
						#self.client_list[CLIENT]["last seen"] = now
						#self.client_list[CLIENT]["name"] = "not discovered yet!"
						#self.client_list[CLIENT]["device class"] = mac_line[-3][2:]
						

					else:
						#lenght_key = self.client_list[CLIENT]["times seen"]
						#lenght_key += 1

						#self.client_list[CLIENT]["probe info"][lenght_key] = {"RX": rx_power,"TS": now}
						#self.client_list[CLIENT]["times seen"] += 1
						#self.client_list[CLIENT]["last seen"] = now

				#se sono alla seconda riga della inquiry
				if v.startswith("Complete local name"):
					#se non ho ancora settato il nome del dispositivo
					#if self.client_list[last_mac]["name"] == "not discovered yet!":
						v = v[:-2]
						client_name = v[22:]

					#	self.client_list[last_mac]["name"] = client_name

						new_bt_device = "NEW Bluetooth dev. MAC address: "+last_mac+", dev name: "+ client_name +", timestamp: "+now+", RSSI: "+rx_power
						print new_bt_device
						#print "ciao"
						
						
						if rasp_mode:
							mosquitto_pub(new_bt_device)

			if in_BLE:
				print "BLE", line
			#print self.client_list
			return self.client_list, True
	
		except:
			pass
	

	def stop(self):
                #print "Try to stop hcidump"
		self.einq = subprocess.Popen(['hcitool', 'epinq'])
		self.bt.kill()
		#self.blescan.kill()



