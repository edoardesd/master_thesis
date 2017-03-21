#!/bin/sh
HOST='files.000webhost.com'
USER='blewizi'
PASSWD='paparoach123'
FILE=$2
DIR=$1
echo "il file è $FILE"
echo "la dir è $DIR quindi $1"

cd $DIR

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
cd /public_html/testa
put $FILE
quit
END_SCRIPT

echo "Se non ci sono errori sopra il caricamento è avvenuto"
exit 0