#! /usr/bin/env bash
USAGE="
Usage:\n\
$0 [dump_suffix]
"
dumpSfx="partial_wnames";
if [ -n "$1" ]; then
dumpSfx="$1";
echo "$dumpSfx passed as suffix";
  if [ "$1" = "--help" ]; then
  echo -e $USAGE;
  exit -1;
  fi
fi
fn="dump_`sbtime short_`_$dumpSfx.csv"
echo "Filename of dump: $fn";
pbpaste > $fn