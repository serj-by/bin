#! /usr/bin/env bash
USAGE="""
Usage:
  $0 <file_to_write.iso> <diskN>
  where diskN disk to write image to (like disk1, disk2 etc. without /dev path)
"""
if [[ -z $1 || -z $2 ]]; then
echo "$USAGE";
exit -1
fi;
outfn=`echo $1 | sed "s|\.iso|\.dmg|"`
echo "out: $outfn"
if [[ -f $outfn ]]; then
echo "$outfn already exists. Please consider manual converting."
exit -2
fi;
hdiutil convert $1 -format UDRW -o $outfn && echo "Converted from $1 to $outfn successfully"
diskutil unmountDisk $2
file_size=$(wc -c $outfn | awk '{print $1}')
echo "Total image size : $file_size. Press trl+T to check progress"
dd if=$outfn of=/dev/$2 bs=1m || rm $outfn; echo "Unable to write to %2. Please consider running script using sudo e.g. sudo $0. Thanks! Exiting."; exit -3; #& ddpid=$!
# TODO: dd failing to finish successfully in bg
#while ps -p $ddpid >&-;
#do
# kill -info $ddpid
# echo "$file_size bytes total to write"
# sleep 1
#done
echo "Wrote $outfn succesfully. Unmounting $2 ..."
diskutil unmountDisk $2
