#!/usr/bin/python
import MySQLdb

db = MySQLdb.connect(host="localhost",    # your host, usually localhost
					 user="root",         # your username
					 passwd="distributedpass" # nella raspberry e' raspberry
					)  


my_name = "\"1__15:33:34_bluetooth\"" #senza  .csv
# you must create a Cursor object. It will let you execute all the queries you need
cur = db.cursor()
cur.execute("SET sql_mode=\'ANSI_QUOTES\'")
cur.execute("USE test") #nome del database
# Use all the SQL you like
cur.execute("CREATE TABLE "+my_name+" (timestamp VARCHAR(30), echo_time FLOAT, rssi INT, tpl INT, lq INT)") 


db.close()	