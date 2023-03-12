#! /usr/bin/env bash
USAGE="
Usage:\n\
$0 [migration_name]
"
. cdmig
migpath=`pwd`/
migfn="synthes_mig__`sbdate`__`sbtime short_`.sql"
echo "Migfn: $migfn"
exit 0
echo "Mig path: $migpath"
if [[ $1 == "--help" ]]; then
echo -e $USAGE;
exit 0;
elif [ -nz $1 ]; then
migfn=$1;
fi
echo cp $mipath_template.sql $migfn
echo pbpaste >> $migfn