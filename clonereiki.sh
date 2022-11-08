#! /usr/bin/env bash
accname="serj-by"
projname="reikiwiki"
intname="r"
git clone git@github.com:$accname/$projname.git
if [ ! -z "$1" ]; then
 echo "Reiki cloned into ./$projname . Renaming to $1/$intname";
 mkdir -p $1
 mv $projname $1/$intname
else
 echo "No param specified. Leaving $projname as it is. To rename use $0 [target-dir]";
fi
