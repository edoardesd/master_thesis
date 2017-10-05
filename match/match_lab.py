import numpy as np
import pprint as pp
import math
import copy
from scipy.optimize import minimize
from operator import itemgetter

lab_intercept = 13.5341
lab_slope = 0.4095

def parse_data(wifi_data, bluetooth_data):
	wifi_set = []
	bluetooth_set = []
	wifi_dat = np.genfromtxt(wifi_data+".txt", delimiter='\n', dtype=None)
	bluetooth_dat = np.genfromtxt(bluetooth_data+".txt", delimiter='\n', dtype=None)


	for line in wifi_dat:
		wifi_set.append(line.split(' '))

	for line in bluetooth_dat:
		bluetooth_set.append(line.split(' '))

	bluetooth_set_new = []
	for line in bluetooth_set:
		line = filter(None, line) 
		bluetooth_set_new.append(line)

	return wifi_set, bluetooth_set_new

def reparse_data(wifi_data, bluetooth_data):
	wifi_set = []
	bluetooth_set = []

	for row in wifi_data:
		wifi_line = []
		for item in row[:-1]:
			item = "%.4f" % float(item)
			wifi_line.append(item)

		#wifi_line.append(row[-1])
		wifi_set.append(wifi_line)

	for row in bluetooth_data:
		bluetooth_line = []
		for item in row[:-1]:
			item = "%.4f" % float(item)
			bluetooth_line.append(item)

		#bluetooth_line.append(row[-1])
		bluetooth_set.append(bluetooth_line)
	return wifi_set, bluetooth_set

def compute_euclidean_distance(wifi_data, bluetooth_data):
	euclidean_dist = {}
	k = 0
	for k in range(len(wifi_data)):
		j = 0
		euc_dict = {}
		for line in wifi_data:
			i = 0
			sum_dist = 0
			for row in line:
				sum_dist = sum_dist + math.pow((float(row) - float(bluetooth_data[k][i])), 2)
				
				i = i + 1
			euc_dist = "%.8f" % math.sqrt(sum_dist)
			euc_dict[j+1] = float(euc_dist)
			j = j + 1

			euclidean_dist[k+1] = euc_dict
		k = k + 1

	return euclidean_dist

def calculate_dist_finger(real_data, fingerprint_data):
	euclidean_dist = {}
	i = 1
	for line_real in real_data:
		#scandisco il dataset di fingeprint
		k = 1
		device_dict = {}
		for line_finger in fingerprint_data:
			
			sum_dist = 0
			for row_real, row_finger in zip(line_real, line_finger):
				#calcolo distanza euclidea per ogni coppia
				sum_dist = sum_dist + math.pow((float(row_real) - float(row_finger)), 2)

			eucl_dist = "%.4f" % math.sqrt(sum_dist)
			device_dict[k] = float(eucl_dist)
			k += 1
		euclidean_dist[i] = device_dict
			
		i += 1

	return euclidean_dist

def print_results_long(distance_dict, rev):
	#rev = True -> descending order
	#rev = False -> ascending order
	for i in range(1, len(distance_dict)+1):
		print "\nDevice",i,": "
		pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev))

def print_results_short(distance_dict, rev, print_res):
	#rev = True -> descending order
	#rev = False -> ascending order
	best_3 = {}
	for i in range(1, len(distance_dict)+1):
		if print_res:
			print "\nDevice",i,": "
			pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)[:3])
		best_3[i] =  sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)[:3]

	return best_3

def extract_labels(dataset):
	labels = []
	for line in dataset:
		labels.append(line[-1])
	return labels

def convert_cells(dataset, labels):
	for key, value in dataset.items():
		for i in range(0, len(dataset[key])):
			dataset[key][i] =list(dataset[key][i])
			dataset[key][i][0] = labels[dataset[key][i][0]-1]
			dataset[key][i] = tuple(dataset[key][i])

	return dataset

def convert_wifi_bt(wifi_data):
	new_matrix = []
	for line in wifi_data:
		new_line = []
		for row in line:
			
			bt_conv = "%.4f" % (float(row)*lab_slope + lab_intercept)
			new_line.append(bt_conv)

		new_matrix.append(new_line)

	return new_matrix

def add_labels(dataset, labels):
	for row, label in zip(dataset, labels):
		row.append(label)

	return dataset

wifi_set, bluetooth_set = parse_data("../dataset/lab/full_wifi_lab", "../dataset/lab/piu_rid_bluetooth_lab")
labels_wifi = extract_labels(wifi_set)
labels_bt = extract_labels(bluetooth_set)
wifi_set, bluetooth_set = reparse_data(wifi_set, bluetooth_set)
wifi_norm_line, bluetooth_norm_line = parse_data("../dataset/lab/norm_wifi_lab", "../dataset/lab/norm_bluetooth_lab")

### NORMALIZZAZIONE RIGHE ###
lab_norm = calculate_dist_finger(bluetooth_norm_line, wifi_norm_line)
best_norm = print_results_short(lab_norm, False, False)
best_norm = convert_cells(best_norm, labels_wifi)
pp.pprint(best_norm)
### CONVERSIONE MATRICE ###

wifi_to_bt_linear = convert_wifi_bt(wifi_set)

euclidean_distance_conversion_linear = calculate_dist_finger(bluetooth_set, wifi_to_bt_linear)


#cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear, bluetooth_set)
best_conv = print_results_short(euclidean_distance_conversion_linear, False, False)
best_conv = convert_cells(best_conv, labels_wifi)
#pp.pprint(best_conv)