import math
from scipy.optimize import minimize

distances = [1.580, 4.272, 8.944, 8.015]
ap_locations = [[0, 0], [4.5, 0], [4.5, 9.5], [0, 9.5]]

# Mean Square Error
# locations: [ (lat1, long1), ... ]
# distances: [ distance1, ... ]
def mse(x, locations, distances):
	mse = 0.0
	i = 0
	for location, distance in zip(ap_locations, distances):
		print "--- x, y: ", x[0], x[1], "--- ap location:", location[0], location[1]
		distance_calculated = euclidean_distance(x[0], x[1], location[0], location[1])
		print "distanza: ", distance_calculated
		mse += math.pow(distance_calculated - distance, 2.0)
		i +=1
	result = mse/4
	print result
	return result

def euclidean_distance(x1, y1, x2, y2):
	#print x1, y1, x2, y2
	sum_square = (x2-x1)**2 + (y2-y1)**2
	return math.sqrt(sum_square)


initial_location = [0,0.5]

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
print result
print location