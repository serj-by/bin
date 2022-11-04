#! /usr/bin/env bash
#! /usr/bin/env bash
actions="install-my install-wb"

SKIP_DOWNLOAD="true"

if [[ $actions == *"install-my"* ]]; then
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
sudo dpkg -i $APTCONFFN

sudo apt-get update
sudo apt-get install mysql-apt-config
# TODO: config root user. By some reason no root user creating during install processs right now.
sudo apt-get install mysql-community-server
# TODO: no longr exists in MySQL repo. Need to download and install manually or via snap (UPD: snap version is broken, so download it and install below).
#sudo apt-get install mysql-workbench-community
#sudo snap install mysql-workbench-community
fi
# / install-my

# Snap version of Workbench looks like broken so installing it from dev site
# install-wb
if [[ $actions == *"install-wb"* ]]; then
# Workench download configs
WBINI_TPL="https://downloads.mysql.com/archives/workbench/?tpl=version&os=22&version=%VER%&osva="
WBDEB_INITFN="/tmp/wbdebinit.html"
UPSTREAM_OS=`cat /etc/upstream-release/lsb-release | grep -Po '(?<=DISTRIB_ID=)(.+)$'`
UPSTREAM_VER=`cat /etc/upstream-release/lsb-release | grep -Po '(?<=DISTRIB_RELEASE=)([\d\.]+)$'`
echo "Upstream OS: $UPSTREAM_OS version $UPSTREAM_VER"
WB_VER="-"
if [ $UPSTREAM_OS = "Ubuntu" ]; then
  case $UPSTREAM_VER in
    "20.04")
	WB_VER="8.0.21"
	;;
    *)
	WB_VER="-"
	;;
  esac
fi

if [ "$WB_VER" = "-" ]; then
  echo "Unsupported OS (upstream is $UPSTREAM_OS ver $UPSTREAM_VER) for Workbench (only few versions of Ubuntu downstreams currently supported). Please install it manually. Exiting."
  exit -2
else
  echo "For your upstream OS version ($UPSTREAM_VER) most suitale wookbench version is $WB_VER"
fi
WBDEB_BASEURL="https://downloads.mysql.com/"
WBINIT_URL=`echo "$WBINI_TPL" | sed "s@%VER%@$WB_VER@"`
if [ -z "$SKIP_DOWNLOAD" ]; then
echo "Processing to download..."
wget $WBINIT_URL -O $WBDEB_INITFN
else
echo "SKIP_DOWNLOAD flag set to $SKIP_DOWNLOAD. Download skipping..."
fi
#gopen $WB_INITFN
WBDEB_REGEXP_ARCHPART="_amd\d+"
WBDEB_REGEXP_VERSPART="`echo $UPSTREAM_OS | tr '[:upper:]' '[:lower:]'`$UPSTREAM_VER$WBDEB_REGEXP_ARCHPART"
WBDEB_REGEXP="\/archives\/get\/p\/\d*\/file\/mysql\-workbench\-community_[\d\.\-]+$WBDEB_REGEXP_VERSPART\.deb"
WBDEB_RELURLCMD="grep -oP '${WBDEB_REGEXP}' $WBDEB_INITFN"
#WBDEB_RELURLCMD="echo /archives/get/p/8/file/mysql-workbench-community_8.0.21-1ubuntu20.04_amd64.deb"
#echo "Try 2 exec $WBDEB_RELURLCMD !!!*"
WBDEB_RELURL=`eval "$WBDEB_RELURLCMD"`
WBDEB_FN=`echo -n $WBDEB_RELURL | grep -oP 'mysql\-workbench\-community_[\d\.]+\-.+?\.deb'`
WBDEB_PATH="/tmp/$WBDEB_FN"
WBDEB_URL="$WBDEB_BASEURL$WBDEB_RELURL"

echo "WB .deb ver part RegExp: $WBDEB_REGEXP_VERSPART"
echo "WB .deb regexp: $WBDEB_REGEXP"
echo "WB .deb init URL: $WBINIT_URL"
echo ".deb rel cmd: $WBDEB_RELURLCMD"
echo ".deb rel URL: $WBDEB_RELURL"
echo ".deb URL: $WBDEB_URL"
echo ".deb FN: $WBDEB_FN"
echo ".deb path: $WBDEB_PATH"

wget -O $WBDEB_PATH -- $WBDEB_URL && echo "WB .deb downloaded. Installing..."
sudo dpkg -i $WBDEB_PATH && echo "MySQL WB installed."

fi
# /install-wb


# config-my
if [[ $actions == *"config-my"* ]]; then
sudo mysql_secure_installation
sudo systemctl restart mysql
fi
# /config-my