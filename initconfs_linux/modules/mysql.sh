#! /usr/bin/env bash
#! /usr/bin/env bash
MYSQLURL="https://dev.mysql.com/"
INITPART="downloads/repo/apt/"
INITFN="/tmp/init.html"
SIGNFN="/tmp/sign.html"
APTCONFFN="/tmp/aptconf.deb"


wget $MYSQLURL$INITPART -O $INITFN
SIGNURL=`cat $INITFN | grep -oP '/downloads/file/\?id=\d+'`
echo "Sign URL: $MYSQLURL$SIGNURL"
wget $MYSQLURL$SIGNURL -O $SIGNFN
APTCONFURL=`cat $SIGNFN | grep -oP '/get/mysql\-apt\-config_[\d\.\-]+_all\.deb'`
echo "APT conf URL: $APTCONFURL"
APTCONFFN=`echo -n $APTCONFURL | sed "s@/get/@/tmp/@"`
echo "!PT conf filename: $APTCONFFN"
#exit 0
wget $MYSQLURL$APTCONFURL -O $APTCONFFN
sudo apt install -f $APTCONFFN

sudo apt-get update
sudo apt-get install mysql-apt-config
# TODO: config root user. By some reason no root user creating during install processs right now.
sudo apt-get install mysql-server
# TODO: no longr exists in MySQL repo. Need to download and install manually or through snap.
#sudo apt-get install mysql-workbench-community
sudo snap install mysql-workbench-community
