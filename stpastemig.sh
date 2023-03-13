#! /usr/bin/env bash
USAGE="
Usage:\n\
$0 [migration_prefix]
"
. cdmig
migpath=`pwd`/
migfn="synthes_mig__`sbdate`__`sbtime short_`.sql"
echo "Mig path: $migpath"
echo "Mig fn: $migfn"
if [ "$1" == "--help" ]; then
echo -e $USAGE;
exit 0;
elif [[ -n $1 ]]; then
migfn=synthes_mig__$1;
fi
cd $migpath
#cp _template.sql $migfn
sed "s/{{date}}/`sbdate dashed`/g" _template.sql | sed "s/{{time}}/`sbtime`/g"> $migfn
pbpaste >> $migfn