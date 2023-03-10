#! /usr/bin/env bash
USAGE="
Usage:\n\
$0 <dump_suffix>>
"
if [ -z $1 ]; then
echo -e $USAGE;
exit -1;
fi
pbpaste > dump_`sbtime short_`_$1.csv