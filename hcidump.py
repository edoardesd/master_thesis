#!/usr/bin/python

import os
import sys
import subprocess
import re

from time import gmtime, strftime



class HcidumpProcessor:


	def __init__(self): 
		pass

	def start(self):
		

		self.bd = subprocess.Popen(['hcidump', '-a'], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		self.logger = sys.stdout #open("/logs/dump.log", "a")

		return self.bd

	def process(self):
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
		
		try:
			v = re.split(r'\s{2,}', line)
			
			if len(v)<2:
				return

			print v

			return "strenge"

		except:
			print "Failed,",line
			traceback.print_exc()
	

	def stop(self):
		self.bd.close()
		bd.kill()



