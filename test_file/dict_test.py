import copy
my_dict = {"C8:14:79:31:3C:29": {"class": "asjdk", "first seen": "asdes", "probe info": {1:{"RX": "-21", "TS": "12:23:23"}, 2:{"RX": "-22", "TS": "12:33:23"}, 3:{"RX": "-41", "TS": "99:23:23"}}, "times seen": "4"}, "XX:14:XX:XX:XX:29": {"class": "asjdk", "first seen": "asdes", "probe info": {1:{"RX": "-21", "TS": "12:23:23"}, 2:{"RX": "-22", "TS": "12:33:23"}, 3:{"RX": "-41", "TS": "99:23:23"}}, "times seen": "4"}}



def bt_to_list(my_dict):
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

print dict_to_list(my_dict)