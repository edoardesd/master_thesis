import numpy as np
import pprint as pp
import math
import copy
from scipy.optimize import minimize
from operator import itemgetter

ap_locations_lab = [[0, 3], [8, 3], [0, 6], [8, 6], [0,10], [8,10]]

initial_location = [0,0]

lab_intercept = 13.5341
lab_slope = 0.4095
lg_slope = [-0.2559, -0.3187]
lg_intercept = [-13.8856, -1.7603]
sams_slope = [-0.2277, -0.2984] 
sams_intercept = [-10.4628, 1.7236]
s3_slope = [-0.2649, -0.4678]
s3_intercept = [-12.9064, 3.8753]
tab_slope = [-0.1221, -0.1333]
tab_intercept = [-4.4764, 2.0018]
ipad_slope = [-0.1002, -0.09975]
ipad_intercept = [-2.9839, 2.73879]
avg_slope=[-0.19416, -0.26359]
avg_intercept = [-8.94302,1.715838]

lab_slope_new = [-0.1371, -0.3261]
lab_intercept_new = [-3.7802, 0.9348]

## PARAMS COL LOG
log_s3_wifi_alpha = -8.548477 
log_s3_wifi_p0 = -56.408953
log_s3_bt_alpha = -3.501016  
log_s3_bt_p0 = 1.825424

log_tab_wifi_alpha = -14.84325
log_tab_wifi_p0 = -47.85378 
log_tab_bt_alpha = -11.04428
log_tab_bt_p0 = 1.91026

log_ipad_wifi_alpha = -9.685008
log_ipad_wifi_p0 = -51.133262
log_ipad_bt_alpha = -3.229079 
log_ipad_bt_p0 = -1.050359

log_lg_wifi_alpha = -15.54680
log_lg_wifi_p0 = -48.22862
log_lg_bt_alpha = -12.2877089 
log_lg_bt_p0 = -0.6120409

log_sams_wifi_alpha = -21.89181
log_sams_wifi_p0 = -42.07718
log_sams_bt_alpha = -8.2023639
log_sams_bt_p0 = -0.1713258

log_lab_wifi_alpha = -8.716259
log_lab_wifi_p0 = -42.860182
log_lab_bt_alpha = -3.425640
log_lab_bt_p0 = -3.624601 

log_avg_wifi_p0 = (log_s3_wifi_p0 + log_ipad_wifi_p0 + log_tab_wifi_p0 + log_lg_wifi_p0 + log_sams_wifi_p0)/5
log_avg_wifi_alpha = (log_s3_wifi_alpha + log_ipad_wifi_alpha + log_tab_wifi_alpha + log_lg_wifi_alpha + log_sams_wifi_alpha)/5
log_avg_bt_p0 = (log_s3_bt_p0 + log_ipad_bt_p0 + log_tab_bt_p0 + log_lg_bt_p0 + log_sams_bt_p0)/5
log_avg_bt_alpha = (log_s3_bt_alpha + log_ipad_bt_alpha + log_tab_bt_alpha + log_lg_bt_alpha + log_sams_bt_alpha)/5

wifi_tesi_p0 = -45
wifi_tesi_alpha = 2.6
bt_tesi_p0 = 0
bt_tesi_alpha = 2.6

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
		best_3[i] =  sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)[:5]

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

def data_to_dist(dataset, wifi):
	new_matrix = []
	i = 0
	if wifi:
		k = 0
	else: k = 1
	for line in dataset:
		new_line = []
		for row in line:
			#if ( i == 0 or i == 5 or i == 10):
			#	y = "%.4f" % (float(row) * lg_slope[k] + lg_intercept[k])
			y = "%.4f" % (float(row) * lab_slope_new[k] + lab_intercept_new[k])

			
			new_line.append(y)

		i += 1
		new_matrix.append(new_line)

	return new_matrix

def convert_to_distance_new_method(wifi_data, bluetooth_data):
	new_matrix_bt = []
	new_matrix_wifi = []
	i = 0
	for i in range(0,len(wifi_data)):
		new_line_wifi = []
		new_line_bt = [] 
		for j in range(0,len(wifi_data[0])):
			
			dist_wifi = "%.8f" % 10**((float((wifi_data[i][j]))+60+6.837576)/(10*(1.941791)))

			if(len(bluetooth_data)>i):
				dist_bluetooth = "%.8f" % 10**((float(bluetooth_data[i][j])+15+6.127945)/(10*(1.836184)))

			if float(dist_wifi) > 15:
				dist_wifi = 15.00000001

			if float(dist_bluetooth) > 15:
				dist_bluetooth = 15.00000001

			new_line_wifi.append(dist_wifi)
			if(len(bluetooth_data)>i):
				new_line_bt.append(dist_bluetooth)
		
		new_matrix_wifi.append(new_line_wifi)
		if(len(bluetooth_data)>i):
			new_matrix_bt.append(new_line_bt)
		
		i = i + 1

	return new_matrix_wifi, new_matrix_bt

# Mean Square Error
# ap_locations: [ (rasp1_x, rasp1_y), ... ]
# distances: [ d_rasp1, ... ]
def mse(x, locations, distances):
	mse = 0.0
	i = 0
	for location, distance in zip(locations, distances):
		distance_calculated = euclidean_distance(x[0], x[1], float(location[0]), float(location[1]))
		mse += math.pow(distance_calculated - float(distance), 2.0)
		i +=1
	result = mse/i
	
	return result

def euclidean_distance(x1, y1, x2, y2):
	#print x1, y1, x2, y2
	sum_square = (x2-x1)**2 + (y2-y1)**2
	return math.sqrt(sum_square)


def convert_bt_labels(data):
	best_lab = {}
	for i in range(0,len(data)):
		best_lab[labels_bt[i]] = data[i+1]

	return best_lab

def create_data_roc(order_dataset,name):
	file = open("../R_files/roc/data/"+name+".txt","w") 
	file.write("pred,survived")
	for key in order_dataset:
		if(key[18:]==order_dataset[key][0][0][18:]):
			str_file = "\n"+str(order_dataset[key][0][1]) + ",1"
			
		else: 
			str_file = "\n"+str(order_dataset[key][0][1]) + ",0"
		
		#print str_file
		file.write(str_file)
	
	file.close() 

wifi_set, bluetooth_set = parse_data("../dataset/lab/full_wifi_lab", "../dataset/lab/piu_rid_bluetooth_lab")
labels_wifi = extract_labels(wifi_set)
labels_bt = extract_labels(bluetooth_set)
wifi_set, bluetooth_set = reparse_data(wifi_set, bluetooth_set)
wifi_norm_line, bluetooth_norm_line = parse_data("../dataset/lab/norm_wifi_lab_bis", "../dataset/lab/norm_bluetooth_lab_bis")
### NORMALIZZAZIONE RIGHE ###
lab_norm = calculate_dist_finger(bluetooth_norm_line, wifi_norm_line)
best_norm = print_results_short(lab_norm, False, False)
best_norm = convert_cells(best_norm, labels_wifi)
best_norm = convert_bt_labels(best_norm)
#pp.pprint(best_norm)
create_data_roc(best_norm,"df.lab_norm")


### CONVERSIONE MATRICE ###
wifi_to_bt_linear = convert_wifi_bt(wifi_set)
euclidean_distance_conversion_matrix = calculate_dist_finger(bluetooth_set, wifi_to_bt_linear)
#cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear, bluetooth_set)
best_conv = print_results_short(euclidean_distance_conversion_matrix, False, False)
best_conv = convert_cells(best_conv, labels_wifi)

best_conv = convert_bt_labels(best_conv)
pp.pprint(best_conv)
create_data_roc(best_conv,"df.lab_conv")


### CONVERSIONE DISTANZA LINEARE
wifi_distance = data_to_dist(wifi_set, True)
bluetooth_distance = data_to_dist(bluetooth_set, False)
euclidean_distance_conversion_linear = calculate_dist_finger(bluetooth_distance, wifi_distance)
best_linear = print_results_short(euclidean_distance_conversion_linear, False, False)
best_linear = convert_cells(best_linear, labels_wifi)

best_linear = convert_bt_labels(best_linear)
#pp.pprint(best_linear)

create_data_roc(best_linear,"df.lab_linear")

### CONVERSIONE DISTANZA LOG
wifi_distance_log, bluetooth_distance_log= convert_to_distance_new_method(wifi_set, bluetooth_set)
euclidean_distance_conversion_log = calculate_dist_finger(bluetooth_distance_log, wifi_distance_log)
best_log = print_results_short(euclidean_distance_conversion_log, False, False)
best_log = convert_cells(best_log, labels_wifi)
best_log = convert_bt_labels(best_log)
#pp.pprint(best_log)
create_data_roc(best_log,"df.lab_log")

####### TRILATERATION #######
wifi_coord = []
for line in wifi_distance_log:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations_lab, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	wifi_coord.append(location)

bt_coord = []
for line in bluetooth_distance_log:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations_lab, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	bt_coord.append(location)


euc_coord = calculate_dist_finger(bt_coord, wifi_coord)
best_tri = print_results_short(euc_coord, False, False)
best_tri = convert_cells(best_tri, labels_wifi)


#pp.pprint(convert_bt_labels(best_tri))