#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import gmtime, strftime

class AirodumpProcessor:

	client_list={}
	bssid_list={}

	def __init__(self):
		pass

	def start(self):
		self.fd = subprocess.Popen(['airodump-ng', 'mon0', '-w', 'fileprova', '--output-format', 'csv'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")
		return self.fd

	def process(self):	
		if not self.fd:
			self.start()

		#recupero la stringa che sta scrivendo airodump
		line = self.fd.stdout.readline()
		
		#setto il tempo attuale
		now = strftime("%H:%M:%S", gmtime())

		#per guardare output di airodump a schermo
		#if line:
			#self.logger.write("L:"+line.encode('ascii', errors='ignore'))

		if not line:
			self.fd.close()
			signal.signal(signal.SIGINT, signal_handler)

		if len(line) < 1:
			self.fd.close()
			signal.signal(signal.SIGINT, signal_handler)

		
		#line = line.replace("\r", "").replace("\n", "").strip()


		try:
			#v=line.split()
			v = re.split(r'\s{2,}', line)
			del v[-1]


			#trova la riga ch elapsed secondi eccc...
			if len(v) < 5:
				return None
 
 			#trova le reti nello spazio in alto
			if v[1].find(":") < 0:
				if v[0].find(":")>0:
					
					BSSID = v[0][1:]
			
					if not self.bssid_list.has_key(BSSID):
						self.bssid_list[BSSID] = {}
						self.bssid_list[BSSID]["ESSID"] = v[-1]
						print self.bssid_list
				return self.bssid_list


			CLIENT = v[1]
			#print "la client list e':", self.client_list
			


			if not self.client_list.has_key(CLIENT):
				
				self.client_list[CLIENT] = {}
				self.client_list[CLIENT]["acc point"] = v[0]
				self.client_list[CLIENT]["first seen"] = now
				self.client_list[CLIENT]["last seen"] = now
				self.client_list[CLIENT]["probes"] = ""
				#self.client_list[CLIENT]["pwr"] = v[2]
				#self.client_list[CLIENT]["rate"] = v[3]
				#self.client_list[CLIENT]["lost"] = v[4]
				#self.client_list[CLIENT]["packets"] = v[5]
				new_client_str = "I've found a new client with mac address "+CLIENT+" at time "+self.client_list[CLIENT]["first seen"]
				print new_client_str

				if(len(v) > 6):
					self.client_list[CLIENT]["probes"] = v[6]

			else:
				#aggiorno last seen
				self.client_list[CLIENT]["last seen"] = now

				#controllo se la rete alla quale e' connesso e' la stessa
				if self.client_list[CLIENT]["acc point"] != v[0]:
					old_acc_point = self.client_list[CLIENT]["acc point"]
					self.client_list[CLIENT]["acc point"] = v[0]
					
					new_accpoint_str = "Client "+CLIENT+" change access point from "+old_acc_point+" to "+self.client_list[CLIENT]["acc point"]
					print new_accpoint_str

				#controllo se sta mandando probes diverse
				if(len(v) > 6):
					if v[6] not in self.client_list[CLIENT]["probes"]:
						self.client_list[CLIENT]["probes"] += v[6]
						self.client_list[CLIENT]["probes"] += "; "
						new_probe_str = "Client "+CLIENT+" sends new probe "+v[6]
						print new_probe_str


			return self.client_list
		except:
			print "Failed,",line
			traceback.print_exc()
	

	def stop(self):
		self.fd.close()
		fd.kill()
		#subprocess.call("killall airodump-ng", shell=True)



