import math
from scipy.optimize import minimize

distances = [1.580, 4.272, 8.944, 8.015]
ap_locations = [[0, 0], [9, 0], [0, 19], [19, 19]]

# Mean Square Error
# locations: [ (lat1, long1), ... ]
# distances: [ distance1, ... ]
def mse(x, locations, distances):
	mse = 0.0
	for location, distance in zip(ap_locations, distances):
		distance_calculated = euclidean_distance(x[0], x[1], location[0], location[1])
		print distance_calculated
		mse += math.pow(distance_calculated - distance, 2.0)
	return mse / 4

def euclidean_distance(x1, y1, x2, y2):
	print x1, y1, x2, y2
	sum_square = (x2-x1)**2 + (y2-y1)**2
	return math.sqrt(sum_square)


x = [0,0]
initial_location = [0,0]

mse(x, ap_locations, distances)

result = minimize(
	mse,                         # The error function
	initial_location,            # The initial guess
	args=(ap_locations, distances), # Additional parameters for mse
	method='L-BFGS-B',           # The optimisation algorithm
	options={
		'ftol':1e-5,         # Tolerance
		'maxiter': 1e+7      # Maximum iterations
	})
location = result.x

print location