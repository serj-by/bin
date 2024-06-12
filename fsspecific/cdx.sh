cd "$HOME/Documents/Personal 2212/x.unz/.x/.myx/Private.old"
pwd
if [ -z $1 ]; then
echo "Param is empty. Exiting..."
else
echo "Param is not empty. Trying to open..."
open .
fi
echo "Done."