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
cmnt=`echo "$2" | sed "s@[^a-zA-Z0-9ЁёА-я]@_@g"`
echo "Comment part of file name: $cmnt"
fi
echo "Dumping main SQL data..."
mysqldump --login-path=$dbloginpath --verbose $1 > $1_`sbdate`__`sbtime short_`__$cmnt.sql
echo "Dumping SQL views..."
myq.sh --dumpviews --silent > views_$1_`sbdate`__`sbtime short_`__$cmnt.sql