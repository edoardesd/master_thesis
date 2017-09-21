#! /bin/bash

line=3
#row=1

for i in `seq 2 4`;
        do
        	for j in `seq 1 5`;
        		do

				#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c${i}_${j}_wifi;"
                	        #mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE d${i}_${j}_wifi;"
                                #mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE d${i}_${j}_bluetooth;"

					
				mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE d${i}_${j}_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
				mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE d${i}_${j}_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"

                                #mysql -u root -pblewizipass -D fingerprint_v2 -e "DELETE FROM b${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"

                done
        done 




#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b2_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4tris_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"

mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d2*_wifi.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d3*_wifi.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d4_1_wifi.csv

mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d2*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d3*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d4_1_bluetooth.csv




<<COMMENTc       
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE b1_1bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE b2_4bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE b3_4bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE b3_4tris_bluetooth;"



mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b1_1bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b2_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4tris_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"


mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c10_4bis_wifi;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c10_4bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c9_4bis_wifi;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c9_4bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c7_2bis_wifi;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c7_2bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c5_2bis_wifi;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE c5_2bis_bluetooth;"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c10_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c9_4bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c7_2bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c5_2bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c10_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c9_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c7_2bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE c5_2bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"


#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_2/rasp*/130917/b*_wifi.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_2/rasp*/130917/b1*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_2/rasp*/130917/b2*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_2/rasp*/130917/b3*_bluetooth.csv

COMMENTc

for i in `seq 2 4`;
        do
                for j in `seq 1 5`;
                        do
                                mysql -u root -pblewizipass -D fingerprint_v2 -e "DELETE FROM d${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
                done
        done  


#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b2_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b3_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b3_4tris_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c5_2bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"

