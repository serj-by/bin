#! /usr/bin/env bash

# Credits:
# https://dev.mysql.com/doc/refman/8.0/en/binary-installation.html
# https://askubuntu.com/questions/595269/use-sed-on-a-string-variable-rather-than-a-file
# https://unix.stackexchange.com/questions/28526/add-a-user-to-the-system-only-if-it-doesnt-exist


getent group mysql &>/dev/null || groupadd mysql || echo "Please condider run `basename $0` as a root"; exit -1;
id -u mysql &>/dev/null || useradd -r -g mysql -s /bin/false mysql
echo "Installing MySQL from $1..."
#cd /usr/local
NAME=`echo $1 | sed "s@.tar.xz@@"`
echo "Base name: $NAME"
#tar xvf $1
#ln -s 