NEWCMD="export PATH=\"`pwd`:\$PATH\""
echo "Path cmd: $NEWCMD"
if [[ `uname -s` -eq "Linux" ]]
then
 PROFILE="/home/`whoami`/.bashrc";
else
 PROFILE="/home/`whoami`/.bash_profile";
fi
echo $NEWCMD >> $PROFILE
echo "Re-applying profile ..."
. $PROFILE