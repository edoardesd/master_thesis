#! /bin/bash

 #mysql -u root -pblewizipass -D finale -e "CREATE TABLE pos3_bluetooth (mac_address VARCHAR(30), timestamp VARCHAR(30), rasp INT, echo_time FLOAT, rssi INT);"
 #mysql -u root -pblewizipass -D finale -e  "CREATE TABLE pos3_wifi (mac_address VARCHAR(30), rasp INT, rx INT, timestamp VARCHAR(30), sn INT);"

#mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,timestamp,rasp,echo_time,rssi' --local -u root -pblewizipass  finale /Users/edoardesd/test_nuove_rasp/rasp*/210917/pos*_bluetooth.csv
mysqlimport  --ignore-lines=1 --fields-terminated-by=, --columns='mac_address,rasp,rx,timestamp,sn' --local -u root -pblewizipass  finale /Users/edoardesd/test_nuove_rasp/rasp*/210917/pos*_wifi.csv
