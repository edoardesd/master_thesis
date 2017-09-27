 #!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime
from datetime import datetime



class AirodumpProcessor:

	client_list={}
	bssid_list={}
	global counter
	counter = 0

	def __init__(self): 
		pass

	def start(self, rasp, path):
		mon_interface = "wlan1mon"
		pwd = subprocess.check_output(['pwd']).rstrip() + "/"
		dev = subprocess.check_output(['cat', pwd+'config/raspi-number.txt'])[:1]
                print dev
                if dev == '6':
                        print "hi guys, jari here"
                        mon_interface = "wlan1"
		rasp_mode = False
		if rasp == True:
			rasp_mode = True
			mon_interface = "wlan0mon"


		#per scrivere su file: '-w', 'lab', '--output-format', 'csv'
		self.fd = subprocess.Popen(['airodump-ng', mon_interface, '--channel', '10'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		#self.logger = sys.stdout #open("/logs/dump.log", "a")

		return self.fd

	def process(self, rasp):
		global counter

		mosq_host = "127.0.0.1"
		mosq_topic = "wifi/log"
		def mosquitto_pub(my_string):
			print "Sending a message to", mosq_host
			subprocess.call("mosquitto_pub -h "+ mosq_host+" -t "+mosq_topic+" -m \""+my_string+"\"", shell=True)



		if not self.fd:
			self.start()

		rasp_mode = False
		#if rasp == True:
		#	rasp_mode = True

		#recupero la stringa che sta scrivendo airodump
		line = self.fd.stdout.readline()

		#setto il tempo attuale
		now = datetime.now().strftime("%H:%M:%S.%f")[:-3]
		#now = strftime("%H:%M:%S", localtime())

		counter +=1
		if (counter%400028 == 0):
			print "WIFI is running!"

		#per guardare output di airodump a schermo
		#if line:
			#self.logger.write("L:"+line.encode('ascii', errors='ignore'))
		if not line:
			return self.client_list, False
		
		if (1):
			v = re.split(r'\s{2,}', line)
			

			#trova la riga ch elapsed secondi eccc...
			if len(v) < 5:
				return self.client_list, True
 			
 			#elimino l'ultima colonna che e' sempre vuota
			if v[-1]=='':
				del v[-1]

 			#trova le reti nello spazio in alto
			if v[1].find(":") < 0:
				#if v[0].find(":")>0:
					
					#BSSID = v[0][1:]
					#if not self.bssid_list.has_key(BSSID):
						#self.bssid_list[BSSID] = {}
						#self.bssid_list[BSSID]["ESSID"] = v[-1]
						#print self.bssid_list
				return self.client_list, True

                        if "B8:27:EB" in v[1]:
                                return self.client_list, True
                        
			CLIENT = v[1]
			BSSID_client = v[0][1:]
			#ts_probe = v[6]
			sn_probe = v[5]
			rx_power = v[2]
			#packet = v[4]


			if not self.client_list.has_key(CLIENT):
				
				self.client_list[CLIENT] = {}

				probe_key = 1
				self.client_list[CLIENT]["times seen"] = 1
				self.client_list[CLIENT]["probe info"] = {probe_key: {"SN": sn_probe, "RX": rx_power,"TS": now}}
				#self.client_list[CLIENT]["acc point"] = BSSID_client
				self.client_list[CLIENT]["first seen"] = now
				self.client_list[CLIENT]["last seen"] = now
				#self.client_list[CLIENT]["probes"] = ""
				new_client_str = "I've found a new client with mac address "+CLIENT+" at time "+self.client_list[CLIENT]["first seen"]
				print new_client_str
				
				if rasp_mode:








					mosquitto_pub(new_client_str)

				#TODO lo split per le varie probes: bisogna considerare ogni probe diversa come stringa separaa
				#ora la stringa delle probes e' unica anche se ne vengono inviate tante. causa piccoli probemi
				
				#if(len(v) > 7):
				#	self.client_list[CLIENT]["probes"] = v[7]

			else:

				#aggiorno last seen
				self.client_list[CLIENT]["last seen"] = now
				lenght_key = self.client_list[CLIENT]["times seen"]

				if sn_probe != self.client_list[CLIENT]["probe info"][lenght_key]["SN"]:
					lenght_key += 1
					self.client_list[CLIENT]["probe info"][lenght_key] = {"SN": sn_probe, "RX": rx_power,"TS": now}
					self.client_list[CLIENT]["times seen"] += 1

				#controllo se la rete alla quale e' connesso e' la stessa
				#if self.client_list[CLIENT]["acc point"] != BSSID_client:
				#	old_acc_point = self.client_list[CLIENT]["acc point"]
				#	self.client_list[CLIENT]["acc point"] = BSSID_client
					
				#	new_accpoint_str = "Client "+CLIENT+" change access point from "+old_acc_point+" to "+self.client_list[CLIENT]["acc point"]
				#	print new_accpoint_str

				#	if rasp_mode:
				#		mosquitto_pub(new_accpoint_str)
						

				#controllo se sta mandando probes diverse
				#if(len(v) > 7):
				#	if v[7] not in self.client_list[CLIENT]["probes"]:
				#		self.client_list[CLIENT]["probes"] += v[7]
				#		self.client_list[CLIENT]["probes"] += "; "
				#		new_probe_str = "Client "+CLIENT+" sends new probe "+v[7]
				#		print new_probe_str

				#		if rasp_mode:
				#			mosquitto_pub(new_probe_str)
	
			return self.client_list, True

		#except:
		#	print "Failed,",line
		#	traceback.print_exc()
	

	def stop(self):
		self.fd.kill()
		#subprocess.call("killall airodump-ng", shell=True)



