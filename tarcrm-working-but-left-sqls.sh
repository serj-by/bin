#! /usr/bin/env bash
#ANAME="ProtonVPN.app.tgz"
#FNAME="ProtonVPN.app"
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
CMD="tar -czvf $ANAME $FNAME"
echo "Ececuting $CMD"
$CMD
if [ $? -eq 0 ]; then
echo "TAR exited with zero status. Success!";
echo "removing $FNAME ...";
CMD="rm -rvf $FNAME"
echo "Ececuting $CMD"
$CMD
echo "$FNAME removed...";
else
echo "Error $? while executing tar -czvf. Nothing will be removed. Error!";
exit $?
fi
