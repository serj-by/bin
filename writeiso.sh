#! /usr/bin/env bash
set -e
FORCEFLAG="--forcermdmg"
USAGE="""
Usage:
  $0 <file_to_write.iso> <diskN> [$FORCEFLAG]
  where diskN disk to write image to (like disk1, disk2 etc. without /dev path)
  
  --forcermdmg paramter force removal of .dmg converted from .iso previously
"""
SCPT_DIR="$(dirname "$0")"
if [[ -z $1 || -z $2 ]]; then
echo "$USAGE";
exit -1
fi;
outfn=`echo $1 | sed "s|\.iso|\.dmg|"`
echo "Checking for $outfn..."
if [[ -f $outfn ]]; then
echo "$outfn exists. Checking for force removal flag ('$3' passed as 3rd arg)..."
  if [ $3 = "$FORCEFLAG" ]; then
    echo "$FORCEFLAG specified. Removing $outfn"
    rm $outfn
  else
    echo "$outfn already exists. Please consider manual converting or add $FORCEFLAG as a 3rd parameter (after disk name)"
    exit -2
  fi;
else
  echo "$outfn file not exists. Processing..."
fi;
hdiutil convert $1 -format UDRW -o $outfn && echo "Converted from $1 to $outfn successfully"
diskutil unmountDisk $2
file_size=$(wc -c $outfn | awk '{print $1}')
echo "Total image size : $file_size"
if [[ "$(id -u)" -ne "0" ]]; then
  rm $outfn;
  echo "Unable to write to $2. Please consider running script using sudo e.g. sudo $0. Thanks! Exiting.";
  exit -3;
fi
echo "Writing $outfn to $2 ..."
echo "Script dir is $SCPT_DIR"
. $SCPT_DIR/ddprogress.sh & ddstpid=$!
sudo dd if=$outfn of=/dev/$2 bs=1m
sudo kill -3 $ddstpid
echo "Wrote $outfn succesfully. Unmounting $2 ..."
diskutil unmountDisk $2
