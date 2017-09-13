#! /bin/bash

line=3
#row=1

for i in `seq 1 10`;
        do
        	for j in `seq 1 5`;
        		do

				mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c${i}_${j}_wifi;"
                	        mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c${i}_${j}_bluetooth;"
					
				mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c${i}_${j}_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
				mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c${i}_${j}_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"

                                mysql -u root -pblewizipass -D fingerprint_v2 -e "DELETE FROM c${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"

                done
        done  

mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c10_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c9_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c7_2bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c5_2bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c10_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c9_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c7_2bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c5_2bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"

<<COMMENT1
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 rasp*/130917/c*_wifi.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 rasp*/130917/c*_bluetooth.csv

for i in `seq 1 10`;
        do
                for j in `seq 1 5`;
                        do
                                mysql -u root -pblewizipass -D fingerprint_v2 -e "DELETE FROM c${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
                done
        done  


mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c10_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c9_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c7_2bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c5_2bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
COMMENT1

