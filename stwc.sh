USAGE="
Usage:\n\
$0 [file-name] [word-prefix]\n\
"
if [ $1 == "--help" ]; then
echo -e $USAGE
exit 0
fi
LC_NUMERIC="en_US.UTF-8"
printf "%'d\n" `grep -o -i "[\[][\[]$2" $1 | wc -l`
LC_NUMERIC="C"
