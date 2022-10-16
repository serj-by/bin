#! /usr/bin/env bash
#! /usr/bin/env bash
MYSQLURL="https://dev.mysql.com/"
INITPART="downloads/repo/apt/"
INITFN="/tmp/init.html"
SIGNFN="/tmp/sign.html"
APTCONFFN="/tmp/aptconf.deb"

# Workench download configs
WBINI_TPL="https://downloads.mysql.com/archives/workbench/?tpl=version&os=22&version=%VER%&osva="

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
sudo dpkg -i $APTCONFFN

sudo apt-get update
sudo apt-get install mysql-apt-config
# TODO: config root user. By some reason no root user creating during install processs right now.
sudo apt-get install mysql-community-server
# TODO: no longr exists in MySQL repo. Need to download and install manually or via snap (UPD: snap version is broken, so download it and install below).
#sudo apt-get install mysql-workbench-community
#sudo snap install mysql-workbench-community

# Snap version of Workbench looks like broken so installing it from dev site
UPSTREAM_OS=`cat /etc/upstream-release/lsb-release | grep -Po '(?<=DISTRIB_ID=)(.+)$'`
UPSTREAM_VER=`cat /etc/upstream-release/lsb-release | grep -Po '(?<=DISTRIB_RELEASE=)([\d\.]+)$'`
echo "Upstream OS ($UPSTREAM_OS) Version: $UPSTREAM_OS_VER"
WB_VER="-"
if [ $UPSTREAM_OS -eq "Ubuntu" ]; then
  case $UPSTREAM_VER in
    "20.04")
	WB_VER="8.0.21"
	;;
    *)
	WB_VER="-"
	;;
  esac
fi

if [ "$WB_VER" -eq "-" ]; then
  echo "Unsupported OS for Workbench (only few versions of Ubuntu downstreams currently supported). Please install it manually. Exiting."
  exit -2
else
  echo "For your upstream OS version ($UPSTREAM_VER) most suitale wookbench version is $WB_VER"
fi

WBINI_URL=`echo "$WBINI_TPL" | sed "s@%VER%@$WB_VER@"`
echo "Wb: $WBINI_URL"




echo "Setup complete. Proessing to configure..."
sudo mysql_secure_installation
sudo systemctl restart mysql