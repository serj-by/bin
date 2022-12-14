#! /usr/bin/env bash
. ~/.mydb_local_conf
db=$2
dbtbltestn=5

dbex=`myq.sh "show databases like '$db';" --silent`
if [ "$dbex" != "$db" ]; then
  q="CREATE DATABASE $db;"
  echo "DB $dbex not found. Exec \" $q \" or just confirm creation here."
  dangerconfirm.sh "create" --verbose || { echo "Import conceled."; exit -1; }
  echo "Creating..."
  myq.sh "$q"
else
  tbls=`myq.sh "select TABLE_NAME from INFORMATION_SCHEMA.tables where tables.TABLE_SCHEMA='$db' limit $dbtbltestn;" --silent`
#  if [[ -n "$tbls" ]] && [[ "$3" -ne "--force" ]]; then
# WIP: conditional binary operator expected
#    if [[ "$3" -ne "--force" && "$3" ~= "--sections=(.+)" ]]; then
#      filtersections.py $3
#    fi
#  fi
    echo -n "$db DB is not empty. First $dbtbltestn tables exist in DB:";
    echo $tbls;
    q="DROP DATABASE $db; CREATE DATABASE $db;"
    echo "Please empty or recreate DB ( $q ) or just confirm to do it here.";
    dangerconfirm.sh "drop" --verbose || { echo "Dropping conceled."; exit -1; }
    echo "Dropping!"
    exit -2
  fi
fi
USAGE="
Usage:\n\
$0 <mysql-dump-filename> <db-name> [--force|--sections=<comma-sparated sections list like dumps|creates>]\n\
"
if [ $1 == "--help" ]; then
echo -e $USAGE
exit 0
fi
if [ ! -f $1 ]; then
echo "$1 not found. Exiting.";
exit -1;
fi 
pv $1 | mysql --login-path=$dbloginpath $2