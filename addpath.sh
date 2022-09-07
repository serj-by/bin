NEWCMD="export PATH=\"`pwd`:\$PATH\""
echo "Path cmd: $NEWCMD"
echo $NEWCMD >> ~/.bash_profile
echo "Re-applying profile ..."
. ~/.bash_profile