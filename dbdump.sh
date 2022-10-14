#! /usr/bin/env bash

if [ -z $1 ]; then
echo "Please specify DB as argument"
exit -1
fi
mysqldump --defaults-extra-file=~/.mysql.local.ini $1 > $1`sbdate`.sql