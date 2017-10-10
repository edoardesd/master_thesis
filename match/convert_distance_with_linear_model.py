import numpy as np
import pprint as pp
import math
import copy
from scipy.optimize import minimize
from operator import itemgetter


ap_locations = [[0, 0], [4.5, 0], [4.5, 9.5], [0, 9.5], [3, 2.25], [6.5,2.25]]
ap_locations_3 = [[0, 0], [4.5, 0], [4.5, 9.5]]

initial_location = [0,0]


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

def print_results_long(distance_dict, rev):
	#rev = True -> descending order
	#rev = False -> ascending order
	results_in_order = {}
	for i in range(1, len(distance_dict)+1):
		#print "\nDevice",i,": "
		#pp.pprint(sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev))
		results_in_order[i] = sorted(distance_dict[i].items(), key=itemgetter(1), reverse=rev)

	return results_in_order
def data_to_dist(dataset, wifi):
	new_matrix = []
	i = 0
	if wifi:
		k = 0
	else: k = 1
	for line in dataset:
		new_line = []
		for row in line:
			if ( i == 0 or i == 5 or i == 10):
				y = "%.4f" % (float(row) * lg_slope[k] + lg_intercept[k])
			elif ( i == 1 or i == 6 or i == 11):
				y = "%.4f" % (float(row) * sams_slope[k] + sams_intercept[k])

			elif ( i == 2 or i == 7 or i == 12):
				y = "%.4f" % (float(row) * s3_slope[k] + s3_intercept[k])

			elif ( i == 3 or i == 8 or i == 13):
				y = "%.4f" % (float(row) * tab_slope[k]+ tab_intercept[k])

			elif ( i == 4 or i == 9 or i == 14):
				y = "%.4f" % (float(row) * ipad_slope[k] + ipad_intercept[k])

			if (y<0):
				y = 0
			new_line.append(y)

		i += 1
		new_matrix.append(new_line)

	return new_matrix

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


wifi_set, bluetooth_set = parse_data("../dataset/wifi", "../dataset/bluetooth")
wifi_set_56, bluetooth_set_56 = parse_data("../dataset/df_completo_wifi", "../dataset/df_completo_bt")
wifi_set_3, bluetooth_set_3 = parse_data("../dataset/wifi_3", "../dataset/bluetooth_3")

distance_wifi =  data_to_dist(wifi_set_56, True)
distance_bt =  data_to_dist(bluetooth_set_56, False)

dist_new = print_results_long(compute_euclidean_distance(distance_wifi, distance_bt), False)
create_data_roc(dist_new,"df.metri_lin_new")

#print_results_long(compute_cos_sim(distance_wifi, distance_bt), True)

####### TRILATERATION #######
wifi_coord = []
for line in distance_wifi:
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
for line in distance_bt:
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

pp.pprint(bt_coord)
pp.pprint(wifi_coord)
euc_coord = compute_euclidean_distance(wifi_coord, bt_coord)
cosine_coord = compute_cos_sim(wifi_coord, bt_coord)
#print_results_long(euc_coord, False)



