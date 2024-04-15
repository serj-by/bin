#! /usr/bin/env bash
OLD_DIR=`pwd`
. cdbaktm
BAKDIR="`pwd`"
SRC="$HOME/www/locamp/sistem"
SRCFN="`basename -- $SRC`"
SRCDIR=`dirname -- $SRC`
BAKFN="$BAKDIR/$SRCFN.tgz"
SHTAG="@SIS_`basename $0`"
COMMENT="$@"
COMMENT_US="`echo -n $COMMENT | tr -c '[[:alnum:]]' '_'`"
echo "
In script tag : $SHTAG
SRC Dir: $SRCDIR
SRC FN: $SRCFN
BAK dir: $BAKDIR
BAK FN: $BAKFN
Comment: $COMMENT
underscored comment: $COMMENT_US
"
echo "Changing dir to $SRCDIR"; cd "$SRCDIR"
#echo -n "exec there: "; pwd;
#CMD="tar --exclude '.git' -czvf $BAKFN -- $SRCFN"
#echo "executing TARCMD: $CMD"
#exec $CMD

# Local backup moved to git section via git archive
#echo "Changing dir to $SRCDIR"; cd "$SRCDIR";
#echo -n "Cur dir is:"; pwd;
#echo "Starting TAR $SRCFN to $BAKFN"
#tar -czvf $BAKFN $SRCFN
#echo "Changing dir 4 git to $SRC"; cd "$SRC"
#echo "Starting git commands in folder `pwd`"
SRCFULLDIR=$SRCDIR/$SRCFN
echo "Going to $SRCFULLDIR"
cd $SRCDIR/$SRCFN
git add .
git commit -m "$*"
git push
git archive HEAD --verbose --output $BAKFN
echo "Backup to $BAKDIR done in `basename $0` by `sbdate dashed`@`sbtime long`."
echo "Going to old dir $OLD_DIR ..."
#cd $SRC
#echo -n "$SHTAG GCMCMD exec in this dir: "; pwd;
#GCMCMD="gcm \"$COMMENT\""
#echo "executing GCMCMD: $GCMCMD"
#. $GCMCMD
cd "$OLD_DIR"
pwd

. keypress.sh

 