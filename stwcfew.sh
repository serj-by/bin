USAGE="
Usage:\n\
$0 [file-name] [[word-prefix]..[word-prefix]x up to 4 times]\n\
"
if [ $1 == "--help" ]; then
echo -e $USAGE
exit 0
fi
LC_NUMERIC="en_US.UTF-8"
n1=`grep -o -i "[\[][\[]$2" $1 | wc -l`
n2=`grep -o -i "[\[][\[]$3" $1 | wc -l`
n3=`grep -o -i "[\[][\[]$4" $1 | wc -l`
n4=`grep -o -i "[\[][\[]$5" $1 | wc -l`
sum=`echo "$n1+$n2+$n3+$n4" | bc`
echo -e "n1 ($2) =$n1\n\
n2 ($3) =$n2\n\
n3 ($4) =$n3\n\
n4 ($5) =$n4\n\
---\n\
Sum: $sum"
LC_NUMERIC="C"
