if [ -z $1 ]
then
NEWCMD="export PATH=\"`pwd`:\$PATH\""
else
NEWCMD="export PATH=\"`realpath $1`:\$PATH\""
fi
echo "Path cmd: $NEWCMD"
OS=`uname -s`
echo "System reported by uname: $OS"
if [ "$OS" -eq "Darwin" ]
then
 echo "Seems like we are on macOS. Using .bash_profile profile file approach"
 PROFILE="$HOME/.bash_profile";
else
 echo "Seems like we are on Linux. Using .bashrc profile file approach"
 PROFILE="$HOME/.bashrc";
fi
echo "Profile file: $PROFILE"
if [ ! -f $PROFLE ]; then
echo "$PROFILE file not exists. Please check correct naming in `realpath $0`. Exiting."
exit -1
else
echo "$PROFILE file exists. Adding new path there."
fi
echo $NEWCMD >> $PROFILE
echo "Re-applying profile ..."
. $PROFILE