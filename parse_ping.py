with open('test.txt') as fp:
	for line in fp:
		if "byte" in line:
			line = line[:-3]
			time_ms = line [-5:] 
			
			print time_ms