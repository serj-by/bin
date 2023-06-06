#! /usr/bin/env bash
FNAME="$1"
ANAME="$1.tgz"
FDIR=`dirname $1`
CDIR=`pwd`
echo "ANAME: $ANAME FNAME: $FNAME";
echo "FDIR: $FDIR CDIR: $CDIR";
if [ $FDIR == "." ]; then
echo "Cur dir is file dir. All set-up.";
else
echo "Please change current dir to file dir. File dir is $FDIR while cur dir is $CDIR . EXIT!";
exit -1;
fi
echo "Cur dir is file dir. Processing...";
echo "Trying to create $ANAME from $FNAME...";
CMD="tar --exclude=.git --exclude=logs/*.log -czvf $ANAME $FNAME"
echo "Ececuting $CMD"
$CMD
if [ $? -eq 0 ]; then
echo "TAR exited with zero status. Success!";
echo "removing $FNAME ...";
CMD="rm -rvf $FNAME"
echo "Ececuting $CMD"
$CMD
echo "$FNAME removed...";
# moved to bksynt
#echo "Moving SQL backups to main backup folder...";
#mv _sql/* . && rm -R _sql
#echo "SQL moved to main backup folder...";
else
echo "Error $? while executing tar -czvf. Nothing will be removed. Error!";
exit $?
fi
