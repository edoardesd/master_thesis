import sys

file=sys.argv[1]
with open(file) as fp:
	for line in fp:
		if "byte" in line:
			line = line[:-3]
			if line[-4] == " ":
				time_ms = line[-4:]		
			elif line[-5] == " ":	
				time_ms = line[-5:]		
			elif line[-6] == " ":
				time_ms = line [-6:]
			else:
				time_ms = line [-7:]   

			
			print time_ms, ""
