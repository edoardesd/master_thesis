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
	result = mse/4
	
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
	for i in range(1, 16):
		print "\nDevice",i,": "
		pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev))

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

		for j in range(0,4):
			if ( i == 0 or i == 5 or i == 10):
				dist_wifi = "%.8f" % 10**((-float(wifi_data[i][j])+p0_mse_wifi)/(10*alpha_mse_double_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+p0_mse_bt)/(10*alpha_mse_double_bt))
			elif ( i == 1 or i == 6 or i == 11):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+p0_mse_wifi)/(10*alpha_mse_double_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+p0_mse_bt)/(10*alpha_mse_double_bt))

			elif ( i == 2 or i == 7 or i == 12):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+p0_mse_wifi)/(10*alpha_mse_double_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+p0_mse_bt)/(10*alpha_mse_double_bt))

			elif ( i == 3 or i == 8 or i == 13):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+p0_mse_wifi)/(10*alpha_mse_double_wifi))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+p0_mse_bt)/(10*alpha_mse_double_bt))

			elif ( i == 4 or i == 9 or i == 14):
				dist_wifi = "%.8f" % 10**((-float((wifi_data[i][j]))+p0_mse_wifi)/(10*alpha_wifi_mse))
				dist_bluetooth = "%.8f" % 10**((-float(bluetooth_data[i][j])+p0_mse_bt)/(10*alpha_bt_mse))
			
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


#dataset import
wifi_set_norm, bluetooth_set_norm = parse_data("dataset/wifi_norm", "dataset/bluetooth_norm")
wifi_set_norm_line, bluetooth_set_norm_line = parse_data("dataset/wifi_norm_line", "dataset/bluetooth_norm_line")
wifi_set, bluetooth_set = parse_data("dataset/wifi", "dataset/bluetooth")
true_dist, bluetooth_ratio = parse_data("dataset/distanze_vere", "dataset/bluetooth_ratio")
wifi_set, bluetooth_ratio2 = parse_data("dataset/wifi", "dataset/bluetooth_ratio2")
wifi_set, bluetooth_ratio3 = parse_data("dataset/wifi", "dataset/bluetooth_ratio3")


###### COMPUTE ALPHA ######
alpha_mat_wifi, alpha_mat_bt = compute_alpha(wifi_set, bluetooth_set)
#print "wifi"
alpha_wifi = print_avg_line(alpha_mat_wifi)
#print "bt"
alpha_bt = print_avg_line(alpha_mat_bt)

####### NORMALIZZAZIONE SU TUTTO #########
euclidean_distance_norm_tot = compute_euclidean_distance(wifi_set_norm, bluetooth_set_norm)
cos_result_tot = compute_cos_sim(wifi_set_norm, bluetooth_set_norm)

#print_results_long(euclidean_distance_norm_tot, True)


####### NORMALIZZAZIONE SULLA LINEA #########
euclidean_distance_norm_line = compute_euclidean_distance(wifi_set_norm_line, bluetooth_set_norm_line)
cos_result_line = compute_cos_sim(wifi_set_norm_line, bluetooth_set_norm_line)

#print_results_long(euclidean_distance_norm_tot, False)


###### CONVERSIONE MATRICE ######
wifi_to_bt_linear = convert_wifi_bt(wifi_set)

euclidean_distance_conversion_linear = compute_euclidean_distance(wifi_to_bt_linear, bluetooth_set)
cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear, bluetooth_set)

#print_results_long(euclidean_distance_conversion_linear, True)


###### MATRICE RAPPORTI ######
euclidean_ratio = compute_euclidean_distance(bluetooth_set, bluetooth_ratio)
cosine_sim_ratio = compute_cos_sim(bluetooth_set, bluetooth_ratio)



###### TRASFORMAZIONE METRI ######
wifi_distance, bluetooth_distance = convert_to_distance(wifi_set, bluetooth_set)
euclidean_with_dist = compute_euclidean_distance(wifi_distance, bluetooth_distance)
cosine_with_dist = compute_cos_sim(wifi_distance, bluetooth_distance)


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


pp.pprint(wifi_coord)
pp.pprint(bt_coord)

euc_coord = compute_euclidean_distance(wifi_coord, bt_coord)
cosine_coord = compute_cos_sim(wifi_coord, bt_coord)
print_results_long(cosine_coord, True)