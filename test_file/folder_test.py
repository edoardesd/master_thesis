import os
import errno

day= "20-05-17"
time= "12:23:23"

def make_sure_path_exists(path):
    if not os.path.exists(path):
    	print "non esiste"
    	os.makedirs("new_folder")


    else:
    	print "esiste"


make_sure_path_exists("log_scripts")