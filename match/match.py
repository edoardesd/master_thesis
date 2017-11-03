import numpy as np
import pprint as pp
import math
import copy
from scipy.optimize import minimize
from operator import itemgetter

ap_locations = [[0, 0], [4.5, 0], [4.5, 9.5], [0, 9.5]]
initial_location = [0,0]


sams_intercept = -57.7674
sams_slope = 0.9739
lg_intercept = -51.399
lg_slope = 1.018
lg_intercept_m = 10.3251
lg_slope_m = 0.4063
s3_intercept = -66.3518
s3_slope = 0.9427
s3_intercept_bis = -62.946
s3_slope_bis = 1.693
tab_intercept = -55.699
tab_slope = 0.895 
tab_intercept_bis = -58.6416
tab_slope_bis = 0.5537 
ipad_intercept = -52.693
ipad_slope = 1.185
ipad_intercept_log = 50.502
ipad_slope_log = 6.707
lg_intercept_log = 51.09
lg_slope_log = 7.57

alpha_lg_wifi = 3.56078844211
alpha_sams_wifi = 2.76024323583
alpha_s3_wifi = 3.13699403395
alpha_tab_wifi = 3.130771425
alpha_ipad_wifi = 2
alpha_wifi_mse =  3.15846486
#alpha_mse_double_wifi = 9.30802122
alpha_mse_double_wifi = 2.8
#p0_mse_wifi = -1.11938027
p0_mse_wifi = -56.16729551

alpha_lg_bt = 3.64839259428
alpha_sams_bt = 2.37049567301
alpha_s3_bt = 2.42663571835
alpha_tab_bt = 2.22172281136
alpha_ipad_bt = 2.47466859867
alpha_bt_mse = 3.07159468
alpha_mse_double_bt = 3.11210661
p0_mse_bt = 1.84665396


lg_1metro_bt = -4.54588
lg_1metro_wifi = -50.26878
sams_1metro_bt = -0.0377
sams_1metro_wifi = -63.6172
s3_1metro_bt = -0.0083
s3_1metro_wifi = -54.0332
tab_1metro_bt = 0
tab_1metro_wifi = -52.1605
ipad_1metro_bt = 0
ipad_1metro_wifi = -51.5707


wifi_set_norm = []
bluetooth_set_norm = []
wifi_set_norm_line = []
bluetooth_set_norm_line = []
bluetooth_set_new = []

wifi_to_bt_linear = []

euclidean_distance_norm_tot = {}
euclidean_distance_norm_line = {}


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

# Mean Square Error
# ap_locations: [ (rasp1_x, rasp1_y), ... ]
# distances: [ d_rasp1, ... ]
def mse(x, locations, distances):
	mse = 0.0
	i = 0
	for location, distance in zip(ap_locations, distances):
		distance_calculated = euclidean_distance(x[0], x[1], float(location[0]), float(location[1]))
		mse += math.pow(distance_calculated - float(distance), 2.0)
		i +=1
	result = mse/i
	
	return result

def euclidean_distance(x1, y1, x2, y2):
	#print x1, y1, x2, y2
	sum_square = (x2-x1)**2 + (y2-y1)**2
	return math.sqrt(sum_square)


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

def compute_cos_sim(wifi_data, bluetooth_data):
	cosine_similarity = {}
	k = 0
	j = 0
	for line_wifi in wifi_data:
		cos_dict = {}
		for line_bt in bluetooth_data:
			cos_res = calculate_cosineSimilarity(line_wifi, line_bt)
			cos_dict[j+1] = float(cos_res)
			j = j + 1
		j = 0

		cosine_similarity[k+1] = cos_dict
		k = k + 1

	return cosine_similarity

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

def print_results_long(distance_dict, rev):
	#rev = True -> descending order
	#rev = False -> ascending order
	results_in_order = {}
	for i in range(1, len(distance_dict)+1):
		#print "\nDevice",i,": "
		#pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev))
		results_in_order[i] = sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)

	return results_in_order

def create_threshold_set(dataset, threshold):
	threshold_dict = {}
	for dev in dataset:
		threshold_dict[dev] = None
		#print "Device", dev, ":"
		under_threshold = []
		for i in range (0, len(dataset)):
			if (dataset[dev][i][1] < threshold):
				under_threshold.append(dataset[dev][i])
				#print dataset[dev][i]

		threshold_dict[dev] = under_threshold
	return threshold_dict

def check_roc(data, dataset_full):
	sotto_soglia = 0
	true_pos = 0
	false_pos = 0
	false_neg = 0
	true_neg = 0
	for dev in data:
		if len(data[dev])>0:
			#print dev, ":", data[dev][0]
			if (data[dev][0][0] == dev):
				true_pos +=1
			else: 
				false_pos +=1
		else:
			sotto_soglia+=1
			if(dataset_full[dev][0][0] == dev):
				false_neg +=1
			else: 
				true_neg +=1


	print "Veri pos: ",true_pos, "    Falsi pos:",false_pos, "    Sotto soglia:", sotto_soglia, "Veri neg:",true_neg, "Falsi neg:", false_neg
	result_roc = [true_pos, false_pos, true_neg, false_neg]
	return result_roc


def print_results_short(distance_dict, rev, print_res):
	#rev = True -> descending order
	#rev = False -> ascending order
	best_3 = {}
	for i in range(1, len(distance_dict)+1):
		if print_res:
			print "\nDevice",i,": "
			pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)[:-47])
		best_3[i] =  sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)[:-47]

	return best_3

def calculate_cosineSimilarity(vecA, vecB):
	dotProduct = DotProduct(vecA, vecB)
	magnitudeOfA = Magnitude(vecA)
	magnitudeOfB = Magnitude(vecB)

	return dotProduct/(magnitudeOfA*magnitudeOfB)

def DotProduct(vecA, vecB):
	dotProduct = 0;
	i = 0
	for i in range(i, len(vecA)):
		dotProduct = dotProduct + (float(vecA[i]) * float(vecB[i]))
	
	return dotProduct
		
def Magnitude(vector):
	return math.sqrt(DotProduct(vector, vector))


def convert_bt_wifi_logaritmic(bt_data):
	new_matrix = []
	i = 0
	for line in bt_data:
		new_line = []
		for row in line:
			if ( i == 0 or i == 5 or i == 10):
				new_line.append(math.log10(abs(float(row)+0.01)) * lg_slope_log + lg_intercept_log)

			elif ( i == 1 or i == 6 or i == 11):
				new_line.append(math.log10(abs(float(row)+0.01)) * lg_slope_log + lg_intercept_log)

			elif ( i == 2 or i == 7 or i == 12):
				new_line.append(math.log10(abs(float(row)+0.01)) * lg_slope_log + lg_intercept_log)

			elif ( i == 3 or i == 8 or i == 13):
				new_line.append(math.log10(abs(float(row)+0.01)) * lg_slope_log + lg_intercept_log)

			elif ( i == 4 or i == 9 or i == 14):
				new_line.append(math.log10(abs(float(row)+0.01)) * ipad_slope_log + ipad_intercept_log)

		i = i + 1
		new_matrix.append(new_line)

	return new_matrix

def convert_wifi_bt(wifi_data):
	new_matrix = []
	i = 0
	for line in wifi_data:
		new_line = []
		for row in line:
			if ( i == 0 or i == 5 or i == 10):
				bt_conv = "%.8f" % (float(row)*lg_slope - lg_intercept)
			elif ( i == 1 or i == 6 or i == 11):
				bt_conv = "%.8f" % (float(row)*sams_slope - sams_intercept)

			elif ( i == 2 or i == 7 or i == 12):
				bt_conv = "%.8f" % (float(row)*s3_slope - s3_intercept)

			elif ( i == 3 or i == 8 or i == 13):
				bt_conv = "%.8f" % (float(row)*tab_slope - tab_intercept)

			elif ( i == 4 or i == 9 or i == 14):
				bt_conv = "%.8f" % (float(row)*ipad_slope -ipad_intercept)
			

			if (float(bt_conv) > 0):
				bt_conv = 0

			new_line.append(bt_conv)

		i = i + 1
		new_matrix.append(new_line)

	return new_matrix

def convert_to_distance(wifi_data, bluetooth_data):
	new_matrix_bt = []
	new_matrix_wifi = []
	i = 0
	for i in range(0,15):
		new_line_wifi = []
		new_line_bt = [] 
		for j in range(0,len(wifi_data[0])):
			if ( i == 0 or i == 5 or i == 10):
				dist_wifi = "%.8f" % 10**((-float(wifi_data[i][j])+lg_1metro_wifi)/(10*alpha_lg_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+lg_1metro_bt)/(10*alpha_lg_bt))
			elif ( i == 1 or i == 6 or i == 11):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+sams_1metro_wifi)/(10*alpha_sams_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+sams_1metro_bt)/(10*alpha_sams_bt))

			elif ( i == 2 or i == 7 or i == 12):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+s3_1metro_wifi)/(10*alpha_s3_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+s3_1metro_bt)/(10*alpha_s3_bt))

			elif ( i == 3 or i == 8 or i == 13):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+tab_1metro_wifi)/(10*alpha_tab_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+tab_1metro_bt)/(10*alpha_tab_bt))

			elif ( i == 4 or i == 9 or i == 14):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+ipad_1metro_wifi)/(10*alpha_ipad_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+ipad_1metro_bt)/(10*alpha_ipad_bt))
			
			if float(dist_wifi) > 15:
				dist_wifi = 15.00000001

			if float(dist_bluetooth) > 15:
				dist_bluetooth = 15.00000001

			new_line_wifi.append(dist_wifi)
			new_line_bt.append(dist_bluetooth)

		i = i + 1
		new_matrix_wifi.append(new_line_wifi)
		new_matrix_bt.append(new_line_bt)

	return new_matrix_wifi, new_matrix_bt



def convert_to_distance_new_method(wifi_data, bluetooth_data):
	new_matrix_bt = []
	new_matrix_wifi = []
	i = 0
	for i in range(0,15):
		new_line_wifi = []
		new_line_bt = [] 
		for j in range(0,len(wifi_data[0])):
			if ( i == 0 or i == 5 or i == 10):
				dist_wifi = "%.8f" % 10**((-float(wifi_data[i][j])+log_lg_wifi_p0)/(10*log_lg_wifi_alpha))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+log_lg_bt_p0)/(10*log_lg_bt_alpha))
			elif ( i == 1 or i == 6 or i == 11):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+log_sams_wifi_p0)/(10*log_sams_wifi_alpha))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+log_sams_bt_p0)/(10*log_sams_bt_alpha))

			elif ( i == 2 or i == 7 or i == 12):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+log_s3_wifi_p0)/(10*log_s3_wifi_alpha))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+log_s3_bt_p0)/(10*log_s3_bt_alpha))

			elif ( i == 3 or i == 8 or i == 13):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+log_tab_wifi_p0)/(10*log_tab_wifi_alpha))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+log_tab_bt_p0)/(10*log_tab_bt_alpha))

			elif ( i == 4 or i == 9 or i == 14):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+log_ipad_wifi_p0)/(10*log_ipad_wifi_alpha))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+log_ipad_bt_p0)/(10*log_ipad_bt_alpha))
			
			if float(dist_wifi) > 15:
				dist_wifi = 15.00000001

			if float(dist_bluetooth) > 15:
				dist_bluetooth = 15.00000001

			new_line_wifi.append(dist_wifi)
			new_line_bt.append(dist_bluetooth)

		i = i + 1
		new_matrix_wifi.append(new_line_wifi)
		new_matrix_bt.append(new_line_bt)

	return new_matrix_wifi, new_matrix_bt

def abs_matrix(my_set):
	set_abs = []
	for line in my_set:
		abs_line = []
		for row in line:
			abs_line.append(abs(float(row)))
		set_abs.append(abs_line)

	return set_abs

def compute_alpha(dataset_wifi, dataset_bt):
	alpha_matrix_wifi = []
	alpha_matrix_bt = []

	for i in range (0,15):
		alpha_line_wifi = []
		alpha_line_bt = []
		for j in range(0,4):
			if ( i == 0 or i == 5 or i == 10):
				alpha_wifi = "%.8f" % -(((float(dataset_wifi[i][j])) - lg_1metro_wifi)/10*math.log10(float(true_dist[i][j])))
				alpha_bt = "%.8f" % -(((float(dataset_bt[i][j])) - lg_1metro_bt)/10*math.log10(float(true_dist[i][j])))

			elif ( i == 1 or i == 6 or i == 11):
				alpha_wifi = "%.8f" % -(((float(dataset_wifi[i][j])) - sams_1metro_wifi)/10*math.log10(float(true_dist[i][j])))
				alpha_bt = "%.8f" % -(((float(dataset_bt[i][j])) - lg_1metro_bt)/10*math.log10(float(true_dist[i][j])))

			elif ( i == 2 or i == 7 or i == 12):
				alpha_wifi = "%.8f" % -(((float(dataset_wifi[i][j])) - s3_1metro_wifi)/10*math.log10(float(true_dist[i][j])))
				alpha_bt = "%.8f" % -(((float(dataset_bt[i][j])) - lg_1metro_bt)/10*math.log10(float(true_dist[i][j])))

			elif ( i == 3 or i == 8 or i == 13):
				alpha_wifi = "%.8f" % -(((float(dataset_wifi[i][j])) - tab_1metro_wifi)/10*math.log10(float(true_dist[i][j])))
				alpha_bt = "%.8f" % -(((float(dataset_bt[i][j])) - lg_1metro_bt)/10*math.log10(float(true_dist[i][j])))

			elif ( i == 4 or i == 9 or i == 14):
				alpha_wifi = "%.8f" % -(((float(dataset_wifi[i][j])) - ipad_1metro_wifi)/10*math.log10(float(true_dist[i][j])))
				alpha_bt = "%.8f" % -(((float(dataset_bt[i][j])) - lg_1metro_bt)/10*math.log10(float(true_dist[i][j])))
			
			alpha_line_wifi.append(alpha_wifi)
			alpha_line_bt.append(alpha_bt)

		alpha_matrix_wifi.append(alpha_line_wifi)
		alpha_matrix_bt.append(alpha_line_bt)

	return alpha_matrix_wifi, alpha_matrix_bt

def print_avg_line(matrix):
	sum_tot = 0
	i = 0
	for line in matrix:
		sum_avg = 0
		for row in line:
			sum_avg = sum_avg + float(row)
			sum_tot = sum_tot + float(row)
			i = i + 1
		avg = sum_avg/4
		#print i/4, avg

	return sum_tot/i

def format_data(dataset):
	nolabels = []
	for line in dataset:
		nolabels.append(line[:-1])

	formatted = []
	for line in nolabels:
		formatted.append(['%.4f' % float(elem) for elem in line ])

	return formatted

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

#wifi true = wifi, wifi false = bt
def calculate_dist_finger_DIFF_DEV(real_data, wifi):
	euclidean_dist = {}

	i = 1
	for line_real in real_data:
		#scandisco il dataset di fingeprint
		k = 1
		#fingerprint_data = avg_wifi_fingerprint
		device_dict = {}
		if (i == 1 or i == 6 or i == 11):
			if wifi:
				fingerprint_data = lg_wifi_fingerprint
			else:
				fingerprint_data = lg_bt_fingerprint


		elif (i == 2 or i == 7 or i == 12):
			if wifi: 
				fingerprint_data = sams_wifi_fingerprint
			else:
				fingerprint_data = sams_bt_fingerprint

		elif (i == 3 or i == 8 or i == 14):
			if wifi: 
				fingerprint_data = s3_wifi_fingerprint
			else:
				fingerprint_data = s3_bt_fingerprint

		else: 
			if wifi:
				fingerprint_data = avg_wifi_fingerprint
			else: 
				fingerprint_data = avg_bt_fingerprint



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

#non serve
def calculate_dist_finger_DIFF_DEV_WIFI(real_data):
	euclidean_dist = {}
	i = 1
	for line_real in real_data:
		#scandisco il dataset di fingeprint
		k = 1
		#fingerprint_data = avg_wifi_fingerprint
		device_dict = {}
		if (i == 1 or i == 6 or i == 11):
			fingerprint_data = lg_wifi_fingerprint

		elif (i == 2 or i == 7 or i == 12):
			fingerprint_data = sams_wifi_fingerprint

		elif (i == 3 or i == 8 or i == 14):
			fingerprint_data = s3_wifi_fingerprint

		else: 
			fingerprint_data = avg_wifi_fingerprint



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

def convert_cells(dataset, labels):
	for key, value in dataset.items():
		for i in range(0, len(dataset[key])):
			dataset[key][i] =list(dataset[key][i])
			dataset[key][i][0] = labels[dataset[key][i][0]-1]
			dataset[key][i] = tuple(dataset[key][i])

	return dataset

def fingerprint_result(wifi_finger, bt_finger, diff_device):

	labels = []
	for line in wifi_finger:
		labels.append(line[-1])

	formatted_wifi = format_data(wifi_finger)
	formatted_bt = format_data(bt_finger)

	if (not diff_device):
		wifi_cells = calculate_dist_finger(wifi_set, formatted_wifi)
		bt_cells = calculate_dist_finger(bluetooth_set, formatted_bt)
	if diff_device:

	#try with mixed df for fingerprint 
		wifi_cells = calculate_dist_finger_DIFF_DEV(wifi_set, True)
		bt_cells = calculate_dist_finger_DIFF_DEV(bluetooth_set, False)


	best_3_wifi = print_results_short(wifi_cells, False, False)
	best_3_bt = print_results_short(bt_cells, False, False)

	best_3_wifi = convert_cells(best_3_wifi, labels)
	best_w_bt = convert_cells(best_3_bt, labels)


	return best_3_wifi, best_3_bt

def threshold_test(low, high, passo, order_dataset):
	matrix_with_different_threshold = []
	for i in np.arange(low, high, passo):
		dataset_threshold = create_threshold_set(order_dataset, i)
	#pp.pprint(norm_threshold)
		roc_array = check_roc(dataset_threshold, order_dataset)
		matrix_with_different_threshold.append(roc_array)

	return matrix_with_different_threshold

def create_data_roc(order_dataset,name):
	file = open("../R_files/roc/data/"+name+".txt","w") 
	file.write("pred,survived")

	for key in order_dataset:
		if(key==order_dataset[key][0][0]):
			str_file = "\n"+str(order_dataset[key][0][1]) + ",1"
			
		else: 
			str_file = "\n"+str(order_dataset[key][0][1]) + ",0"
		
		#print str_file
		file.write(str_file)
	
	file.close() 


def max_min(dataset):
	max_r = 0
	min_r = 9999999
	for key in dataset:
		for tup in dataset[key]:
			if(tup[1]>max_r):
				max_r = tup[1]
			if(tup[1]<min_r):
				min_r = tup[1]
	return max_r, min_r

def dataset_normalizza(dataset):
	max_l, min_l = max_min(dataset)
	diff = max_l-min_l
	dict2 = copy.deepcopy(dataset)
	for key in dataset:
		for i in range(0, len(dataset[key])):
			#print key, dataset[key][i]
			dict2[key][i] =list(dict2[key][i])
			dataset[key][i] = list(dataset[key][i])
			dict2[key][i][1] = "%.4f" % float((dataset[key][i][1]-min_l)/diff)
			dict2[key][i] = tuple(dict2[key][i])

	print max_l, min_l
	return dict2
#dataset import
wifi_set_norm, bluetooth_set_norm = parse_data("../dataset/wifi_norm", "../dataset/bluetooth_norm")
wifi_set_norm_line, bluetooth_set_norm_line = parse_data("../dataset/wifi_norm_line", "../dataset/bluetooth_norm_line")
wifi_set, bluetooth_set = parse_data("../dataset/wifi", "../dataset/bluetooth")
wifi_avg_all, bluetooth_avg_all = parse_data("../dataset/fingerprint/sams_avg_all_wifi", "../dataset/fingerprint/sams_avg_all_bt")
true_dist, bluetooth_ratio = parse_data("../dataset/distanze_vere", "../dataset/bluetooth_ratio")
wifi_set, bluetooth_ratio2 = parse_data("../dataset/wifi", "../dataset/bluetooth_ratio2")
wifi_set, bluetooth_ratio3 = parse_data("../dataset/wifi", "../dataset/bluetooth_ratio3")


###### COMPUTE ALPHA ######
alpha_mat_wifi, alpha_mat_bt = compute_alpha(wifi_set, bluetooth_set)
#print "wifi"
alpha_wifi = print_avg_line(alpha_mat_wifi)
#print "bt"
alpha_bt = print_avg_line(alpha_mat_bt)

####### NORMALIZZAZIONE SU TUTTO #########
euclidean_distance_norm_tot = compute_euclidean_distance(wifi_set_norm, bluetooth_set_norm)
cos_result_tot = compute_cos_sim(wifi_set_norm, bluetooth_set_norm)

#print_results_long(euclidean_distance_norm_tot, False)


####### NORMALIZZAZIONE SULLA LINEA #########
euclidean_distance_norm_line = compute_euclidean_distance(wifi_set_norm_line, bluetooth_set_norm_line)
cos_result_line = compute_cos_sim(wifi_set_norm_line, bluetooth_set_norm_line)

norm_order = print_results_long(euclidean_distance_norm_line, False)
#pp.pprint(norm_order)
#pp.pprint(threshold_test(0, 1.5, 0.1, norm_order))
###### CONVERSIONE MATRICE ######
wifi_to_bt_linear = convert_wifi_bt(wifi_set)

euclidean_distance_conversion_linear = compute_euclidean_distance(wifi_to_bt_linear, bluetooth_set)
cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear, bluetooth_set)


#print_results_long(euclidean_distance_conversion_linear, False)


###### MATRICE RAPPORTI ######
#euclidean_ratio = compute_euclidean_distance(bluetooth_set, bluetooth_ratio)
#cosine_sim_ratio = compute_cos_sim(bluetooth_set, bluetooth_ratio)



###### TRASFORMAZIONE METRI ######
wifi_distance, bluetooth_distance = convert_to_distance(wifi_set, bluetooth_set)
euclidean_with_dist = compute_euclidean_distance(wifi_distance, bluetooth_distance)
cosine_with_dist = compute_cos_sim(wifi_distance, bluetooth_distance)

#print_results_long(euclidean_with_dist, False)

####### TRILATERATION #######
wifi_coord = []
for line in wifi_distance:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	wifi_coord.append(location)

bt_coord = []
for line in bluetooth_distance:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	bt_coord.append(location)


euc_coord = compute_euclidean_distance(wifi_coord, bt_coord)
cosine_coord = compute_cos_sim(wifi_coord, bt_coord)
#print_results_long(cosine_coord, True)


print "------------------------------------------"

###############   RASP 5 e RASP 6   #############

wifi_set_56, bluetooth_set_56 = parse_data("../dataset/df_completo_wifi", "../dataset/df_completo_bt")
wifi_norm_line_56, bluetooth_norm_line_56 = parse_data("../dataset/df_completo_norm_line_wifi", "../dataset/df_completo_norm_line_bt")
wifi_norm_56, bluetooth_norm_56 = parse_data("../dataset/df_completo_norm_wifi", "../dataset/df_completo_norm_bt")


wifi_norm_line_3, bluetooth_norm_line_3 = parse_data("../dataset/df_norm_line_wifi_3", "../dataset/df_norm_line_bt_3")


####### NORMALIZZAZIONE SULLA LINEA #########
euclidean_distance_norm_line = compute_euclidean_distance(wifi_norm_line_56, bluetooth_norm_line_56)
cos_result_line = compute_cos_sim(wifi_norm_line_56, bluetooth_norm_line_56)

line_norm_56 = print_results_long(euclidean_distance_norm_line, False)
check_roc(create_threshold_set(line_norm_56, 0.25),line_norm_56)



#create_data_roc(line_norm_56,"df.line_norm_56")
norm_norm = dataset_normalizza(line_norm_56)
create_data_roc(norm_norm,"df.norm_norm")
#pp.pprint(threshold_test(0, 1.5, 0.1, line_norm_56))


####### NORMALIZZAZIONE SULLA LINEA ######### SOLO PRIME 3 RASP
euclidean_distance_norm_line_3 = compute_euclidean_distance(wifi_norm_line_3, bluetooth_norm_line_3)
cos_result_line_3 = compute_cos_sim(wifi_norm_line_3, bluetooth_norm_line_3)

#print_results_long(euclidean_distance_norm_line_3, False)


####### NORMALIZZAZIONE SU TUTTO #########
euclidean_distance_norm_tot = compute_euclidean_distance(wifi_norm_56, bluetooth_norm_56)
cos_result_tot = compute_cos_sim(wifi_norm_56, bluetooth_norm_56)

#print_results_long(cos_result_tot, True)

###### CONVERSIONE MATRICE ######
wifi_to_bt_linear_56 = convert_wifi_bt(wifi_set_56)

euclidean_distance_conversion_linear = compute_euclidean_distance(wifi_to_bt_linear_56, bluetooth_set_56)
cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear_56, bluetooth_set_56)

conversione_56 = print_results_long(euclidean_distance_conversion_linear, False)
#pp.pprint(conversione_56)
#pp.pprint(threshold_test(0, 30, 2, conversione_56))
#create_data_roc(conversione_56,"df.conversione_56")


conversione_norm = dataset_normalizza(conversione_56)
create_data_roc(conversione_norm,"df.conversione_norm")


###### TRASFORMAZIONE METRI ######
wifi_distance_56, bluetooth_distance_56 = convert_to_distance(wifi_set_56, bluetooth_set_56)
euclidean_with_dist = compute_euclidean_distance(wifi_distance_56, bluetooth_distance_56)
cosine_with_dist = compute_cos_sim(wifi_distance_56, bluetooth_distance_56)

metri_lineare_56 = print_results_long(euclidean_with_dist, False)
#create_data_roc(metri_lineare_56,"df.metri_lineare_56")
metri_lineare_norm = dataset_normalizza(metri_lineare_56)
create_data_roc(metri_lineare_norm,"df.metri_lineare_norm")



#### FINGERPRINT ####

avg_wifi_fingerprint_6, avg_bt_fingerprint_6 = parse_data("../dataset/fingerprint/f_6_all_wifi", "../dataset/fingerprint/f_6_all_bt")
sams_wifi_fingerprint_6, sams_bt_fingerprint_6 = parse_data("../dataset/fingerprint/f_6_sams_wifi", "../dataset/fingerprint/f_6_sams_bt")
s3_wifi_fingerprint_6, s3_bt_fingerprint_6 = parse_data("../dataset/fingerprint/f_6_s3_wifi", "../dataset/fingerprint/f_6_s3_bt")
lg_wifi_fingerprint_6, lg_bt_fingerprint_6 = parse_data("../dataset/fingerprint/f_6_lg_wifi", "../dataset/fingerprint/f_6_lg_bt")

sams_wifi_fingerprint, sams_bt_fingerprint = parse_data("../dataset/fingerprint/fingerprint_sam_wifi_mean", "../dataset/fingerprint/fingerprint_sam_bt_mean")
s3_wifi_fingerprint, s3_bt_fingerprint = parse_data("../dataset/fingerprint/s3_wifi_avg", "../dataset/fingerprint/s3_bt_ist")
lg_wifi_fingerprint, lg_bt_fingerprint = parse_data("../dataset/fingerprint/lg_wifi_avg", "../dataset/fingerprint/lg_bt_avg")
avg_wifi_fingerprint, avg_bt_fingerprint = parse_data("../dataset/fingerprint/fingerprint_wifi_avg", "../dataset/fingerprint/fingerprint_bt_avg")



finger_wifi, finger_bt = fingerprint_result(avg_wifi_fingerprint, avg_bt_fingerprint, True)

for i in range (1, 16):
	check = False
	if (finger_wifi[i][0][0] == finger_bt[i][0][0]):
		check = True
	#print i, ")", finger_wifi[i][0][0], "---", finger_bt[i][0][0], check
	check = False


###### TRASFORMAZIONE METRI LOG ######
wifi_distance_56, bluetooth_distance_56 = convert_to_distance_new_method(wifi_set, bluetooth_set)
euclidean_with_dist_56 = compute_euclidean_distance(wifi_distance_56, bluetooth_distance_56)
cosine_with_dist_56 = compute_cos_sim(wifi_distance_56, bluetooth_distance_56)

metri_log_56 = print_results_long(euclidean_with_dist_56, False)
#create_data_roc(metri_log_56,"df.metri_log_56")
metri_log_norm = dataset_normalizza(metri_log_56)
create_data_roc(metri_log_norm,"df.metri_log_norm")


####### TRILATERATION #######
wifi_coord = []
for line in wifi_distance_56:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	wifi_coord.append(location)

bt_coord = []
for line in bluetooth_distance_56:
	result = minimize(
		mse,                         # The error function
		initial_location,            # The initial guess
		args=(ap_locations, line), # Additional parameters for mse
		method='L-BFGS-B',           # The optimisation algorithm
		options={
			'ftol':1e-5,         # Tolerance
			'maxiter': 1e+7      # Maximum iterations
		})
	location = result.x
	bt_coord.append(location)


euc_coord = compute_euclidean_distance(wifi_coord, bt_coord)
cosine_coord = compute_cos_sim(wifi_coord, bt_coord)
#print_results_long(cosine_coord, True)






