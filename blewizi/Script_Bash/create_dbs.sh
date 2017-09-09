#! /bin/bash

line=3
#row=1

for i in `seq 1 10`;
        do
        	for j in `seq 1 5`;
        		do
					#mysql -u root -pblewizipass -D fingerprint -e  "CREATE TABLE f_${i}_${j}_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"
                	mysql -u root -pblewizipass -D fingerprint -e  "DELETE FROM f_${i}_${j}_wifi WHERE (mac_address!='C4:43:8F:B3:0A:F7' AND mac_address!='D8:90:E8:29:AD:3F');"
                	#mysql -u root -pblewizipass -D fingerprint -e "ALTER IGNORE TABLE f_${i}_${j}_bluetooth ADD UNIQUE (mac_address, timestamp, rasp, echo_time, rssi);"
                done
        done  

#USE fingerprint
#SET @row = 1;
#SET @line = 4;
#SET @create = CONCAT('CREATE TABLE f_', @row , '_', @line ,'_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);');
#PREPARE stmt FROM @create;
#EXECUTE stmt;
#MY_QUERY