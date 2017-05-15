#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import localtime, strftime



class BluetoothProcessor:

	client_list={}
	bssid_list={}

	def __init__(self): 
		pass

	def start(self):

		self.fd = subprocess.Popen(['l2ping', 'C8:14:79:31:3C:29'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")

		return self.fd

	def process(self):


		if not self.fd:
			self.start()

		#recupero la stringa che sta scrivendo airodump
		line = self.fd.stdout.readline()
		
		#setto il tempo attuale
		now = strftime("%H:%M:%S", localtime())

		#per guardare output di airodump a schermo
		#if line:
			#self.logger.write("L:"+line.encode('ascii', errors='ignore'))
		if not line:
			return False
		
		try:
			print line
			
	
			return True

		except:
			print "Failed,",line
			traceback.print_exc()
	

	def stop(self):
		self.fd.kill()



