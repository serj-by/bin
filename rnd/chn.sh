#! /usr/bin/env bash
# credits: https://stackoverflow.com/questions/9057387/process-all-arguments-except-the-first-one-in-a-bash-script (via Pavman)
echo "times: $1"
echo "opts: ${@:2}"
for i in $(seq $1); do
#echo $i
#echo "exec ~/ch.py ${@:2}";
~/dev/bin/rnd/ch.py ${@:2};
done
