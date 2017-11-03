import math
import itertools
import numpy as np
import pprint as pp
from scipy.optimize import minimize

distance_test = [[1.580, 4.272, 8.944, 8.015], [1.580, 3.162, 9.487, 9.124]]
rssi_test = [[-15.8034, -22.2419, -33.4667, -35.0000], [-0.8027, -3.2450, -15.1118, -21.0058]]
p_zero = 0
p_zero_wifi = -54.33
p_zero_bt = 1.53062667
initial_alpha = 1
x = []
x.append(initial_alpha)
x.append(p_zero)

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

wifi_set, bluetooth_set = parse_data("../dataset/wifi", "../dataset/bluetooth")
wifi_set, distance_set = parse_data("../dataset/wifi", "../dataset/distanze_vere")


def rssi_formula(alpha, rssi, p0):	
	return float("%.8f" % 10**((-rssi+p0)/(10*alpha)))


#x = alpha
def mse_alpha(x, distances, rssi_values):
	mse = 0.0
	for rssi, distance in itertools.izip(rssi_values, distances):
		mse += mse_line(x,distance, rssi)

	print "min squared error", mse
	return mse/len(rssi_values)


def mse_line(x, distances_line, rssi_values_line):
	a = x[0]
	p_z = x[1]
	mse = 0.0
	for rssi, distance in itertools.izip(rssi_values_line, distances_line):
		distance_calculated = rssi_formula(a, float(rssi), p_z)

		print distance_calculated, "vs", distance
		mse += math.pow(distance_calculated - float(distance), 2.0)
	result = mse/len(rssi_values_line)
	print result
	return result


#mse_alpha(initial_alpha, distance_test, rssi_test)




lg_subset_wifi = []
sams_subset_wifi = []
s_subset_wifi = []
tab_subset_wifi = []
ipad_subset_wifi = []
for i in range(0,15):
	if (i%5==0):
		lg_subset_wifi.append(wifi_set[i])
	elif (i%5==1):
		sams_subset_wifi.append(wifi_set[i])
	elif (i%5==2):
		s_subset_wifi.append(wifi_set[i])
	elif (i%5==3):
		tab_subset_wifi.append(wifi_set[i])
	elif (i%5==4):
		ipad_subset_wifi.append(wifi_set[i])

lg_subset_dist = []
sams_subset_dist = []
s_subset_dist = []
tab_subset_dist = []
ipad_subset_dist = []
for i in range(0,15):
	if (i%5==0):
		lg_subset_dist.append(distance_set[i])
	elif (i%5==1):
		sams_subset_dist.append(distance_set[i])
	elif (i%5==2):
		s_subset_dist.append(distance_set[i])
	elif (i%5==3):
		tab_subset_dist.append(distance_set[i])
	elif (i%5==4):
		ipad_subset_dist.append(distance_set[i])

lg_subset_bt = []
sams_subset_bt = []
s_subset_bt = []
tab_subset_bt = []
ipad_subset_bt = []
for i in range(0,15):
	if (i%5==0):
		lg_subset_bt.append(bluetooth_set[i])
	elif (i%5==1):
		sams_subset_bt.append(bluetooth_set[i])
	elif (i%5==2):
		s_subset_bt.append(bluetooth_set[i])
	elif (i%5==3):
		tab_subset_bt.append(bluetooth_set[i])
	elif (i%5==4):
		ipad_subset_bt.append(bluetooth_set[i])

bnds = ((1.4, 2.8), (None, 0))

result = minimize(
	mse_alpha,                         # The error function
	x,            # The initial guess
	args=(distance_set, wifi_set), # Additional parameters for mse
	method='L-BFGS-B',           # The optimisation algorithm
	bounds = bnds,
	options={
		'ftol':1e-5,         # Tolerance		
		'maxiter': 1e+7,     # Maximum iterations
		'disp': True
	})
alpha = result
print result
print alpha.x
