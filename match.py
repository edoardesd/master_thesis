import numpy as np
import pprint as pp
import math
import copy
from operator import itemgetter

print_info = 2

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

wifi_set_norm = []
bluetooth_set_norm = []
wifi_set_norm_line = []
bluetooth_set_norm_line = []
bluetooth_set_new = []

wifi_to_bt_linear = []

euclidean_distance_norm_tot = {}
euclidean_distance_norm_line = {}

#euclidean_distance_conversion_linear = {}


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

def abs_matrix(my_set):
	set_abs = []
	for line in my_set:
		abs_line = []
		for row in line:
			abs_line.append(abs(float(row)))
		set_abs.append(abs_line)

	return set_abs


#dataset import
wifi_set_norm, bluetooth_set_norm = parse_data("wifi_norm", "bluetooth_norm")
wifi_set_norm_line, bluetooth_set_norm_line = parse_data("wifi_norm_line", "bluetooth_norm_line")
wifi_set, bluetooth_set = parse_data("wifi", "bluetooth")
wifi_set, bluetooth_ratio = parse_data("wifi", "bluetooth_ratio")
wifi_set, bluetooth_ratio2 = parse_data("wifi", "bluetooth_ratio2")
wifi_set, bluetooth_ratio3 = parse_data("wifi", "bluetooth_ratio3")



pp.pprint(bluetooth_ratio2)


####### NORMALIZZAZIONE SU TUTTO #########
euclidean_distance_norm_tot = compute_euclidean_distance(wifi_set_norm, bluetooth_set_norm)
cos_result_tot = compute_cos_sim(wifi_set_norm, bluetooth_set_norm)



####### NORMALIZZAZIONE SULLA LINEA #########
euclidean_distance_norm_line = compute_euclidean_distance(wifi_set_norm_line, bluetooth_set_norm_line)
cos_result_line = compute_cos_sim(wifi_set_norm_line, bluetooth_set_norm_line)

#print_results_long(euclidean_distance_norm_tot, False)




###### CONVERSIONE MATRICE ######
wifi_to_bt_linear = convert_wifi_bt(wifi_set)

euclidean_distance_conversion_linear = compute_euclidean_distance(wifi_to_bt_linear, bluetooth_set)
cosine_similarity_conversion_linear = compute_cos_sim(wifi_to_bt_linear, bluetooth_set)

euclidean_ratio = compute_euclidean_distance(bluetooth_set, bluetooth_ratio1)
cosine_sim_ratio = compute_cos_sim(bluetooth_set, bluetooth_ratio1)


print_results_long(cosine_sim_ratio, True)







