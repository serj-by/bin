#! /usr/bin/env bash
fldname="/Volumes/DATAEXT/_dev/_soft/_mediawiki"
arname="mediawiki-1.38.4"
tarext="tar.gz"
intname="r"
tar xzvf "$fldname/$arname.$tarext" $arname
if [ ! -z "$1" ]; then
 echo "MW unpacked into ./$arname . Renaming to $1/$intname";
 mkdir -p $1
 mv $arname $1/$intname
else
 echo "No param specified. Leaving $arname as it is. To rename use $0 [target-dir]";
fi
