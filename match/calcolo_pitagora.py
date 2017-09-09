import math


x = 0.5
y = 0.5

somma_quadrati = math.pow(x, 2) + pow(y, 2)
dist = "%.3f" % math.sqrt(somma_quadrati)


print "Distanza da rasp: ", dist