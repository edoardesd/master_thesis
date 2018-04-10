#! /bin/bash

line=3
#row=1


for j in `seq 0 10`;
	do

		#mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "DROP TABLE ${j}metri_wifi;"
                #mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "DROP TABLE ${j}metri_bluetooth;"
                #mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "DROP TABLE ${j}metri_hcidump;"

					
		#mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "CREATE TABLE ${j}metri_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
		#mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "CREATE TABLE ${j}metri_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT, lq INT, tpl INT);"
                mysql -u root -pblewizipass -h 127.0.0.1 -D corridoio -e  "CREATE TABLE ${j}metri_hcidump (mac_address VARCHAR(30), rasp INT, rx VARCHAR(30), timestamp VARCHAR(30));"
                #mysql -u root -pblewizipass -D new_lab -e "DELETE FROM h${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A' AND mac_address!='D8:90:E8:29:AD:3F');"

        done

#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -h 127.0.0.1 -pblewizipass  corridoio /Users/edoardesd/Documents/master_thesis/parametri_corridoio/231017/*_wifi.csv
#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi,lq,tpl' --local -u root -h 127.0.0.1 -pblewizipass corridoio /Users/edoardesd/Documents/master_thesis/parametri_corridoio/231017/*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp' --local -u root -h 127.0.0.1 -pblewizipass  corridoio /Users/edoardesd/Documents/master_thesis/parametri_corridoio/231017/*_hcidump.csv


<<COMMENTc       


#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b2_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "CREATE TABLE b3_4tris_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"

#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d2*_wifi.csv
#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d3*_wifi.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  fingerprint_v3 /Users/edoardesd/fingerprint_56/rasp*/220917/h*_wifi.csv

#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d2*_bluetooth.csv
#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v2 /Users/edoardesd/fingerprint_3/rasp*/160917/d3*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  fingerprint_v3 /Users/edoardesd/fingerprint_56/rasp*/220917/h*_bluetooth.csv




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



for i in `seq 2 4`;
        do
                for j in `seq 1 5`;
                        do
                                mysql -u root -pblewizipass -D fingerprint_v2 -e "DELETE FROM d${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
                done
        done  
COMMENTc

#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b2_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b3_4bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM b3_4tris_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"
#mysql -u root -pblewizipass -D fingerprint_v2 -e  "DELETE FROM c5_2bis_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='C8:14:79:31:3C:2A');"

