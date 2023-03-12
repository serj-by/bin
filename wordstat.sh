#! /usr/bin/env bash
. ~/.mydb_local_conf
dbname=$default_dbname

silent=false
if [[ $2 == "--silent" ]]; then
silent=true
fi

#echo -n "silent: "
#echo "$silent"

if [ -n $1 ]; then
if [[ ! $silent ]]; then echo "First param is not empty - $1 . Using as DB name"; fi
dbname=$1
else
if [[ ! $silent ]]; then echo "No first param. Using $dbname as default."; fi
fi
if [[ ! $silent ]]; then echo "DB: $dbname"; fi
myq.sh --countwords --nosilent $dbname
myq.sh --lastwordid --nosilent $dbname
myq.sh --lastwordtitle --nosilent $dbname
