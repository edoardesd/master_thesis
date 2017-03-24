#! /bin/bash

HOST_HOME='blewizi.suroot.com'
USER_HOME='edoardesd'
PASSWD_HOME='blewizipass'

HOST="files.000webhost.com"	
USER="blewizi"
PASSWD="bubusette123"

FILE=$2
DIR=$1

echo diretttoria $DIR

arrDIR=(${DIR//// })

echo ${arrDIR[*]}
DIR_1=${arrDIR[0]}
DIR_2=${arrDIR[1]}

echo $DIR_1
echo "il file è $FILE"
echo "la dir è $DIR quindi $1, slpitto $DIR_1 e $DIR_2"

cd $DIR

ftp -n $HOST_HOME <<END_SCRIPT
quote USER $USER_HOME
quote PASS $PASSWD_HOME
binary
mkdir $DIR_1
put $FILE
quit
END_SCRIPT


ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
cd /public_html/testa
mkdir $DIR_1
cd $DIR_1
mkdir $DIR_2
cd $DIR_2
put $FILE
quit
END_SCRIPT

echo "Se non ci sono errori sopra il caricamento è avvenuto"
exit 0