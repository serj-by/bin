NEWCMD="export PATH=\"`pwd`:\$PATH\""
echo "Path cmd: $NEWCMD"
echo "System: `uname -s`"
if [[ `uname -s` -eq "Darwin" ]]
then
 PROFILE="$HOME/.bash_profile";
else
 PROFILE="$HOME/.bashrc";
fi
if [ ! -f $PROFLE ]; then
echo "$PROFILE file not exists. Please check correct naming in `realpath $0`. Exiting."
exit -1
else
echo "$PROFILE file exists. Adding $NEWCMD there."
fi
echo $NEWCMD >> $PROFILE
echo "Re-applying profile ..."
. $PROFILE