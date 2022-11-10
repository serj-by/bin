#! /usr/bin/env bash
. ~/.mydb_local_conf
USAGE="
Usage:\n\
$0 <dbname>
"
if [ -z $1 ]; then
echo -e $USAGE;
exit -1;
fi
mysqldump -u root -prootmysql $1 > $1_`sbdate`__`sbtime short_`.sql