corans="Yes, I really need it. Please do."
verbose=false
if [ "$2" == "--verbose" ]; then
verbose=true
fi
if [ -z "$1" ] ; then
  if $verbose ; then echo "Answer not provided. Using default answer."; fi
else
  if $verbose ; then echo "Using \" $1 \" as answer."; fi
  corans="$1";
fi
echo "Please type \" $corans \" (without surrounding quotes and spaces) to confirm action."
read ans
if [ "$ans" != "$corans" ]; then
  echo "Canceling action in $0."
  exit -10;
fi
echo "Ok, here we go from $0..."
exit 0