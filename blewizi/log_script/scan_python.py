from bluetooth import *

print "performing inquiry..."

while 1:
	nearby_devices = discover_devices()
