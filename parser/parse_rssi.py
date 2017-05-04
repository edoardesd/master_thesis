import sys
import copy

file=sys.argv[1]
print file[71:]
sys.stdout = open(file[71:], 'w')

print file
my_mymac=False

with open(file) as fp:
	for line in fp:
		splitted = line.split(" ")

		
		if len(splitted)>1:
			if splitted[1].count(":")>4:
				if "48:D2:24:8F:C6:B8" in splitted[1]:
					mac_addr=splitted[1]
					my_mymac=False
				else:
					mac_addr=splitted[1]
					my_mymac=True
					print "\n\n"+mac_addr

			if splitted[0].count(":")>4:
				if "48:D2:24:8F:C6:B8" in splitted[0]:
					mac_addr=splitted[0]
					my_mymac=False
				else:
					mac_addr=splitted[0]
					my_mymac=True
				


			if my_mymac:
				str_list = list(filter(None, splitted))
				if "-" in str_list[0]:
					copied = copy.deepcopy(str_list[0])
					print str_list[0][2:][:2]

		#print space