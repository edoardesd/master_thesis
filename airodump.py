#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime



class AirodumpProcessor:

	client_list={}
	bssid_list={}

	def __init__(self): 
		pass

	def start(self, rasp):
		mon_interface = "mon0"
		rasp_mode = False
		if rasp == True:
			rasp_mode = True
			mon_interface = "wlan1mon"

		self.fd = subprocess.Popen(['airodump-ng', mon_interface, '-w', 'fileprova', '--output-format', 'csv'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")

		return self.fd

	def process(self, rasp):
		mosq_host = "192.168.1.4"
		mosq_topic = "wifi/log"
		def mosquitto_pub(my_string):
			print "Sending a message to", mosq_host
			subprocess.call("mosquitto_pub -h "+ mosq_host+" -t "+mosq_topic+" -m \""+my_string+"\"", shell=True)



		if not self.fd:
			self.start()

		rasp_mode = False
		if rasp == True:
			rasp_mode = True

		#recupero la stringa che sta scrivendo airodump
		line = self.fd.stdout.readline()
		
		#setto il tempo attuale
		now = strftime("%H:%M:%S", localtime())

		#per guardare output di airodump a schermo
		#if line:
			#self.logger.write("L:"+line.encode('ascii', errors='ignore'))
		if not line:
			return self.client_list, False
		
		try:
			v = re.split(r'\s{2,}', line)
			

			#trova la riga ch elapsed secondi eccc...
			if len(v) < 5:
				return self.client_list, True
 			
 			#elimino l'ultima colonna che e' sempre vuota
			if v[-1]=='':
				del v[-1]

 			#trova le reti nello spazio in alto
			if v[1].find(":") < 0:
				if v[0].find(":")>0:
					
					BSSID = v[0][1:]
					if not self.bssid_list.has_key(BSSID):
						self.bssid_list[BSSID] = {}
						self.bssid_list[BSSID]["ESSID"] = v[-1]
						print self.bssid_list
				return self.bssid_list, True

			CLIENT = v[1]
			BSSID_client = v[0][1:]

			if not self.client_list.has_key(CLIENT):
				
				self.client_list[CLIENT] = {}
				self.client_list[CLIENT]["acc point"] = BSSID_client
				self.client_list[CLIENT]["first seen"] = now
				self.client_list[CLIENT]["last seen"] = now
				self.client_list[CLIENT]["probes"] = ""
				#self.client_list[CLIENT]["pwr"] = v[2]
				#self.client_list[CLIENT]["rate"] = v[3]
				#self.client_list[CLIENT]["lost"] = v[4]
				#self.client_list[CLIENT]["packets"] = v[5]
				new_client_str = "I've found a new client with mac address "+CLIENT+" at time "+self.client_list[CLIENT]["first seen"]
				print new_client_str
				
				if rasp_mode:
					mosquitto_pub(new_client_str)

				#TODO lo split per le varie probes: bisogna considerare ogni probe diversa come stringa separaa
				#ora la stringa delle probes e' unica anche se ne vengono inviate tante. causa piccoli probemi
				if(len(v) > 6):
					self.client_list[CLIENT]["probes"] = v[6]

			else:
				#aggiorno last seen
				self.client_list[CLIENT]["last seen"] = now

				#controllo se la rete alla quale e' connesso e' la stessa
				if self.client_list[CLIENT]["acc point"] != BSSID_client:
					old_acc_point = self.client_list[CLIENT]["acc point"]
					self.client_list[CLIENT]["acc point"] = BSSID_client
					
					new_accpoint_str = "Client "+CLIENT+" change access point from "+old_acc_point+" to "+self.client_list[CLIENT]["acc point"]
					print new_accpoint_str

					if rasp_mode:
						mosquitto_pub(new_accpoint_str)
						

				#controllo se sta mandando probes diverse
				if(len(v) > 6):
					if v[6] not in self.client_list[CLIENT]["probes"]:
						self.client_list[CLIENT]["probes"] += v[6]
						self.client_list[CLIENT]["probes"] += "; "
						new_probe_str = "Client "+CLIENT+" sends new probe "+v[6]
						print new_probe_str

						if rasp_mode:
							mosquitto_pub(new_probe_str)
	
			return self.client_list, True

		except:
			print "Failed,",line
			traceback.print_exc()
	

	def stop(self):
		self.fd.kill()
		#subprocess.call("killall airodump-ng", shell=True)



