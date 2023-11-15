#! /usr/bin/env bash
. ~/.mydb_local_conf
DB="sistem";
OLD_DIR=`pwd`
. cdbaktm
BAKDIR="`pwd`"
SRC="$HOME/www/locamp/sistem"
SRCFN="`basename -- $SRC`"
SRCDIR="`dirname -- $SRC`"
BAKFN="$BAKDIR/$SRCFN.tgz"
SHTAG="@SIS_`basename $0`"
DUMP_FN_PREFIX="sistem__"
echo "
In script tag : $SHTAG
SRC Dir: $SRCDIR
SRC FN: $SRCFN
BAK dir: $BAKDIR
BAK FN: $BAKFN
"
echo "Changing dir to $BAKDIR"; cd "$BAKDIR"


mydump_fn="$DUMP_FN_PREFIX`sbdate`__`sbtime short_`.sql"
mysqldump --login-path=$dbloginpath --verbose --routines $DB > $mydump_fn
echo "Dir b4 gzip: `pwd`"
gzip $mydump_fn

echo "Changing dir back to $OLD_DIR"; cd "$OLD_DIR"
