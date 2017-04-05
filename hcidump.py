#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime


class HcidumpProcessor:

	client_list={}

	global in_inquiry

	def __init__(self): 
		pass

	def start(self, rasp):
		
		rasp_mode = False
		if rasp == True:
			rasp_mode = True

		self.sinq = subprocess.call(['hcitool spinq'], shell=True)
		try:
			self.blescan = subprocess.call(['hcitool lescan'], shell=True)
		except:
			pass
		self.bd = subprocess.Popen(['hcidump', '-a'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")

		in_inquiry = False
		
		return self.bd

	def process(self, rasp):
		global in_inquiry
		global last_mac
		
		mosq_host = "192.168.1.4"
		mosq_topic = "bt/log"

		def mosquitto_pub(my_string):
			print "Sending a message to", mosq_host
			subprocess.call("mosquitto_pub -h "+ mosq_host+" -t "+mosq_topic+" -m \""+my_string+"\"", shell=True)
		


		if not self.bd:
			self.start()

		rasp_mode = False
		if rasp == True:
			rasp_mode = True

		#recupero la stringa che sta scrivendo airodump
		line = self.bd.stdout.readline()

		#setto il tempo attuale
		now = strftime("%H:%M:%S", localtime())

		#per guardare output a schermo
		#if line:
			#elf.logger.write("L:"+line.encode('ascii', errors='ignore'))

		if not line:
			return self.client_list, False		

		try:

			if "sniffer - Bluetooth" in line:
				in_inquiry = False
				print "HCIDUMP is running!"

			if "Extended Inquiry" in line:
				in_inquiry = True
				#print line
			

			if "Extended Inquiry" not in line and (line[0] == ">" or line[0] == "<"):
				in_inquiry = False


			#se sono dentro l'inquiry
			if in_inquiry:
				#elimino la tabbata iniziale
				v = line.replace("    ", "")
				if v.startswith("bdaddr"):
					mac_line = v.split()
					CLIENT = mac_line[1]
					last_mac = CLIENT
				
					#prima volta che scopro il nuovo client
					if not self.client_list.has_key(CLIENT):
						self.client_list[CLIENT] = {}
						self.client_list[CLIENT]["first seen"] = now
						self.client_list[CLIENT]["last seen"] = now
						self.client_list[CLIENT]["name"] = "not discovered yet!"
						self.client_list[CLIENT]["rssi"] = mac_line[-1]
						self.client_list[CLIENT]["device class"] = mac_line[-3][2:]

					else:
						self.client_list[CLIENT]["last seen"] = now

				#se sono alla seconda riga della inquiry
				if v.startswith("Complete local name"):
					#se non ho ancora settato il nome del dispositivo
					if self.client_list[last_mac]["name"] == "not discovered yet!":
						v = v[:-2]
						client_name = v[22:]

						self.client_list[last_mac]["name"] = client_name

						new_bt_device = "Find a new Bluetooth device at time "+self.client_list[last_mac]["first seen"]+". Mac address: "+last_mac+" , device name: "+ self.client_list[last_mac]["name"]
						print new_bt_device

						if rasp_mode:
							mosquitto_pub(new_bt_device)

				

			return self.client_list, True
	
		except:
			pass
	

	def stop(self):
		self.einq = subprocess.call(['hcitool epinq'], shell=True)
		self.bd.kill()
		#self.blescan.kill()



