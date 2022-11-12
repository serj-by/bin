#! /usr/bin/env bash
. ~/.mydb_local_conf
USAGE="
Usage:\n\
$0 <dbname> [<comment>]
"
if [ -z $1 ]; then
echo -e $USAGE;
exit -1;
fi
if [ -n "$2" ]; then
cmnt=`echo "$2" | sed "s@[^a-zA-A\d]@_@g"`
echo "Comment part of file name: $cmnt"
fi

mysqldump --login-path=$dbloginpath --verbose $1 > $1_`sbdate`__`sbtime short_`__$cmnt.sql