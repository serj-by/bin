#! /usr/bin/env bash
# credits: https://stackoverflow.com/questions/9057387/process-all-arguments-except-the-first-one-in-a-bash-script (via Pavman)
#	   https://stackoverflow.com/questions/43440425/most-frequent-element-in-an-array-bash-3-2 via rici
#echo "times: $1"
#echo "opts: ${@:2}"
declare -a resarr=()
for i in $(seq $1); do
#echo $i
#echo "exec ~/ch.py ${@:2}";
res=`~/dev/bin/rnd/ch.py ${@:2}`
echo "$res"
resarr+=($res)
done
echo "ResArr: ${resarr[@]}"
echo -n "MAX: "
printf '%s\n' "${resarr[@]}" | sort -n | uniq -c | sort -k1,1nr -k2n | awk '{print $2; exit}'
