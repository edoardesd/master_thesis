import csv, sys, copy

my_dict = {"C8:14:79:31:3C:29": {"class": "asjdk", "first seen": "asdes", "probe info": {1:{"RX": "-21", "TS": "12:23:23", "SN": "12321"}, 2:{"RX": "-22", "TS": "12:33:23", "SN": "12321"}, 3:{"RX": "-41", "TS": "99:23:23", "SN": "12321"}}, "times seen": "4"}, "XX:14:XX:XX:XX:29": {"class": "asjdk", "first seen": "asdes", "probe info": {1:{"RX": "-21", "TS": "12:23:23", "SN": "12321"}, 2:{"RX": "-22", "TS": "12:33:23"}, 3:{"RX": "-41", "TS": "99:23:23"}}, "times seen": "4"}}

def dict_to_list(my_dict):
	final_list = []

	for mac in my_dict:
		for ts in my_dict[mac]:
			my_list = []
			my_list.append(ts)
			for val in my_dict[mac][ts]:
				#print my_dict[mac][ts][val]
				my_list.append(my_dict[mac][ts][val])
			final_list.append(my_list)

	return final_list	


def hc_to_list(my_dict):
	final_list = []

	for mac in my_dict:
		my_list = []
		my_list.append(mac)
		if my_dict[mac]["probe info"]:
			for info in my_dict[mac]["probe info"]:
				my_list.append(my_dict[mac]["probe info"][info]["RX"])
				my_list.append(my_dict[mac]["probe info"][info]["TS"])
				final_list.append(copy.deepcopy(my_list))
				my_list.remove(my_dict[mac]["probe info"][info]["RX"])
				my_list.remove(my_dict[mac]["probe info"][info]["TS"])

	return final_list

def csv_dict_writer(path, fieldnames, data):
    """
    Writes a CSV file using DictWriter
    """
    with open(path, "wb") as out_file:
        writer = csv.DictWriter(sys.stderr, delimiter=',', fieldnames=fieldnames)
        writer.writeheader()
        for row in data:
            writer.writerow(row)
#----------------------------------------------------------------------
if __name__ == "__main__":
    data = bt_to_list(my_dict)
    csv_list = []
    print data
    fieldnames = "timestamp, echo_time, lq, tpl".split(",")
    fieldnames = "mac address, RX, timestamp".split(",")
    for values in data:
        inner_dict = dict(zip(fieldnames, values))
        csv_list.append(inner_dict)

    print csv_list
    path = "dict_output.csv"
    csv_dict_writer(path, fieldnames, csv_list)



'''
with open('my_csv.csv', 'wb') as f:  # Just use 'w' mode in 3.x
    w = csv.writer(sys.stderr, delimiter='\t')#, fieldnames="[time], [echo_time]")
    #w.writeheader()
    for i in my_dict:
    	#print i, "\n"
    	#w.writerow([i])
    	
    	for x in my_dict[i]:
    		#print x, my_dict[i][x], "\n"
    		#print my_dict[i][x]["echo_time"]
    		w.writerow([x, my_dict[i][x].values()])

    print "--------------------------"
    #w.writerow(my_dict.keys())
'''