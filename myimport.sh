#! /usr/bin/env bash
. ~/.mydb_local_conf
db=$2
USAGE="
Usage:\n\
$0 <mysql-dump-filename> <db-name>\n\
"
if [ "$1" == "--help" ]; then
echo -e $USAGE
exit 0
fi
if [ ! -f $1 ]; then
echo "$1 not found. Exiting.";
exit -1;
fi 
#if [ "$3" == "--nopv" ]; then
#  mysql --login-path=$dbloginpath $2 < $1
#else
  pv $1 | mysql --login-path=$dbloginpath $2
#fi
