NEWCMD="export PATH=\"`pwd`:\$PATH\""
echo "Path cmd: $NEWCMD"
if [[ `uname -s` -eq "Linux" ]]
then
 PROFILE="/home/`whoami`/.bashrc";
else
 PROFILE="/home/`whoami`/.bash_profile";
fi
if [ ! -f PROFLE ]; then
echo "$PROFILE file not exists. Please check correct naming in `realpath $0`. Exiting."
exit -1
fi
echo $NEWCMD >> $PROFILE
echo "Re-applying profile ..."
. $PROFILE