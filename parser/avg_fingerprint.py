import numpy as np
import pprint as pp
import math
import copy
from operator import itemgetter

def create_shrink_df(order_dataset,name):
	file = open(name+".txt","w") 
	file.write("rasp1,rasp2,rasp3,rasp4,location\n")

	for key in order_dataset:
		string = key[0]+","+key[1]+","+key[2]+","+key[3]+","+key[4]+"\n"
		file.write(string)
	
	file.close() 

def parse_data(wifi_data, bluetooth_data):
	wifi_set = []
	bluetooth_set = []
	wifi_dat = np.genfromtxt(wifi_data+".csv", delimiter='\n', dtype=None)
	bluetooth_dat = np.genfromtxt(bluetooth_data+".csv", delimiter='\n', dtype=None)


	for line in wifi_dat:
		wifi_set.append(line.split(' '))

	for line in bluetooth_dat:
		bluetooth_set.append(line.split(' '))

	bluetooth_set_new = []
	for line in bluetooth_set:
		line = filter(None, line) 
		bluetooth_set_new.append(line)

	return wifi_set[1:], bluetooth_set_new[1:]

def shrink_df(df):

	prec = 'asd'
	cont = 1
	cont_list = []
	for line in df:
		actual = line[0].split(',')[4]
		#print prec == actual
		if (prec == actual):
			cont=cont+1
			#print cont
		else: 
			print cont, prec
			cont_list.append(cont)
			cont = 1


		prec = line[0].split(',')[4]
	cont_list.append(cont)
	i = 0

	time = []
	cont_list = cont_list[1:]
	for item in cont_list:
		if item >= 10:
			time.append(item/10)
		else: 
			time.append(item)


	r1 = 0
	r2 = 0
	r3 = 0
	r4 = 0 
	print time
	k = 0
	i = 1
	j = -1
	new_frame = []
	for line in df:
		vect = line[0].split(',')
		actual = vect[4]

		#print prec == actual
		if (prec == actual):
			r1 = r1 + float(vect[0])
			r2 = r2 + float(vect[1])
			r3 = r3 + float(vect[2])
			r4 = r4 + float(vect[3])
			#print prec, actual, prec==actual
			#print i, time[j]

			
			if(i == time[j]):
				#print "i e' :", i
				k = k+1
				#print "k e': ", k
				if (k<11):
					new_frame.append(["%.4f" % float(r1/i),"%.4f" %float(r2/i),"%.4f" %float(r3/i),"%.4f" %float(r4/i),actual])
					print actual, k
				
				i = 1
				r1 = 0
				r2 = 0
				r3 = 0
				r4 = 0
			else: 
				i = i+1
		else: 
			r1 = 0
			r2 = 0
			r3 = 0
			r4 = 0
			k = 0
			i = 1
			j = j+1
			if(time[j]==1):
				vect = line[0].split(',')
				r1 = r1 + float(vect[0])
				r2 = r2 + float(vect[1])
				r3 = r3 + float(vect[2])
				r4 = r4 + float(vect[3])
				new_frame.append(["%.4f" % float(r1/i),"%.4f" %float(r2/i),"%.4f" %float(r3/i),"%.4f" %float(r4/i),actual])
				k = k +1
				r1 = 0
				r2 = 0
				r3 = 0
				r4 = 0
			if(cont_list[j]%10==0):
				vect = line[0].split(',')
				r1 = r1 + float(vect[0])
				r2 = r2 + float(vect[1])
				r3 = r3 + float(vect[2])
				r4 = r4 + float(vect[3])

				i=i+1
				if(cont_list[j]==10):
					i = 0
					r1 = 0
					r2 = 0
					r3 = 0
					r4 = 0

			#print prec, actual, prec==actual


		prec = vect[4]
		#print i
		#print r1/i, r2/i, r3/i, r4/i

	return new_frame


lg_wifi_4, sams_bt_4 = parse_data("fingerprint/lg_wifi_4", "fingerprint/sam_bt_4")

#sh_lg = shrink_df(lg_wifi_4)
sh_sams_bt = shrink_df(sams_bt_4)
pp.pprint(sh_sams_bt)

create_shrink_df(sh_sams_bt, "test2")
#create_shrink_df(sh_lg, "test")