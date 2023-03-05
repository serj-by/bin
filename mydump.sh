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
mydump_fn=$1_`sbdate`__`sbtime short_`__$cmnt.sql
echo "Dumping main SQL data into $mydump_fn ..."
mysqldump --login-path=$dbloginpath --verbose --routines $1 > $mydump_fn
echo "Start GZipping SQL data in $0 for $mydump_fn ..."
gzip $mydump_fn
echo "Finished GZipping SQL data in $0 for $mydump_fn ..."
myviews_fn=views_$1_`sbdate`__`sbtime short_`__$cmnt.sql
echo "Dumping SQL views in $0 for $myviews_fn ..."
myq.sh --dumpviews --silent > $myviews_fn