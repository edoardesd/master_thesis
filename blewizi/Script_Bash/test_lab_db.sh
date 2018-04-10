#! /bin/bash



#for j in `seq 1 5`;
 #       do
        	

		#mysql -u root -pblewizipass -D lab_dataset -e  "DROP TABLE lab_n${j}_wifi;"
                #mysql -u root -pblewizipass -D lab -e  "DROP TABLE lab_n${j}_bluetooth;"
                #mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE d${i}_${j}_bluetooth;"

					
		#mysql -u root -pblewizipass -D lab_new -e  "CREATE TABLE dataset_lab_pos${j} (rasp1 FLOAT, rasp2 FLOAT, rasp3 FLOAT, rasp4 FLOAT, rasp5 FLOAT, rasp6 FLOAT, mac_address VARCHAR(30), pos INT);"
		#mysql -u root -pblewizipass -D lab_new -e  "CREATE TABLE bluetooth_dataset_lab_pos${j} (rasp1 FLOAT, rasp2 FLOAT, rasp3 FLOAT, rasp4 FLOAT, rasp5 FLOAT, rasp6 FLOAT, mac_address VARCHAR(30), pos INT);"


  #      done 

for j in `seq 6 12`;
        do
                

                #mysql -u root -pblewizipass -D lab_dataset -e  "DROP TABLE lab_n${j}_wifi;"
                #mysql -u root -pblewizipass -D lab -e  "DROP TABLE lab_n${j}_bluetooth;"
                #mysql -u root -pblewizipass -D fingerprint_v2 -e  "DROP TABLE d${i}_${j}_bluetooth;"
                mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE new_lab${j}_wifi;"
                mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE new_lab${j}_bluetooth;"
                                        
                mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE new_lab${j}_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
                mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE new_lab${j}_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
        done 

mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE lab_new4_wifi;"
mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE lab_new4_bluetooth;"
mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE lab_new5_wifi;"
mysql -u root -pblewizipass -D new_lab -e  "DROP TABLE lab_new5_bluetooth;"

mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE lab_new4_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE lab_new4_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"

mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE lab_new5_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
mysql -u root -pblewizipass -D new_lab -e  "CREATE TABLE lab_new5_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
#mysql -u root -pblewizipass -D lab -e  "CREATE TABLE lab_n9_bis_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
#mysql -u root -pblewizipass -D lab -e  "CREATE TABLE lab_n9_bis_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"


mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  new_lab /Users/edoardesd/Documents/master_thesis/test_lab3/rasp*/new_lab*_wifi.csv

mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  new_lab /Users/edoardesd/Documents/master_thesis/test_lab3/rasp*/new_lab*_bluetooth.csv

mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  new_lab /Users/edoardesd/Documents/master_thesis/test_lab3/rasp*/lab_new*_wifi.csv

mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  new_lab /Users/edoardesd/Documents/master_thesis/test_lab3/rasp*/lab_new*_bluetooth.csv



#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='avg,mac_address,rasp' --local -u root -pblewizipass  lab /Users/edoardesd/Documents/master_thesis/test_lab/mysql/wifi1/*_wifi.csv
