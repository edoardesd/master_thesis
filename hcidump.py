#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import gmtime, strftime


class HcidumpProcessor:

	client_list={}

	global in_inquiry

	def __init__(self): 
		pass

	def start(self):
		
		self.sinq = subprocess.call(['hcitool spinq'], shell=True)
		self.bd = subprocess.Popen(['hcidump', '-a'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")
		in_inquiry = False
		return self.bd

	def process(self):
		global in_inquiry
		global last_mac
		#in_inquiry = True
		if not self.bd:
			self.start()

		#recupero la stringa che sta scrivendo airodump
		line = self.bd.stdout.readline()
		
		#setto il tempo attuale
		now = strftime("%H:%M:%S", gmtime())

		#per guardare output a schermo
		#if line:
			#elf.logger.write("L:"+line.encode('ascii', errors='ignore'))

		if not line:
			self.bd.close()

		if len(line) < 1:
			self.bd.close()
		

		#setto il tempo attuale
		now = strftime("%H:%M:%S", gmtime())

		try:

			if "sniffer - Bluetooth" in line:
				in_inquiry = False
				print "hcidump starts!"

			if "Extended Inquiry" in line:
				in_inquiry = True
				#print line
			

			if "Extended Inquiry" not in line and (line[0] == ">" or line[0] == "<"):
				in_inquiry = False


			if in_inquiry:
				#print line
				v = line.replace("    ", "")
				if v.startswith("bdaddr"):
					mac_line = v.split()
					CLIENT = mac_line[1]
					last_mac = CLIENT
					print mac_line[1]
					
					if not self.client_list.has_key(CLIENT):
						self.client_list[CLIENT] = {}
						self.client_list[CLIENT]["first seen"] = now
						self.client_list[CLIENT]["last seen"] = now
						self.client_list[CLIENT]["name"] = "not discovered yet!"
						self.client_list[CLIENT]["rssi"] = mac_line[-1]
						self.client_list[CLIENT]["device class"] = mac_line[-3][2:]
				print v
				

				if v.startswith("Complete local name"):
					v = v[:-2]
					client_name = v[22:]

					self.client_list[last_mac]["name"] = client_name



				print self.client_list
		

			return self.client_list

		except:
			print "Failed,",line
			traceback.print_exc()
	

	def stop(self):
		self.bd.close()
		self.sinq.close()
		self.einq = subprocess.call(['hcitool epinq'], shell=True)
		self.einq.close()
		bd.kill()



