#! /usr/bin/env bash
LOGDIR="/Volumes/LIN/log"
#LOGDIR="/$HOME/log"
LOGFN="df.log.txt"
cd "$LOGDIR"
touch "$LOGFN"
echo "$LOGFN created,"
echo -n '' > "$LOGFN"
echo "$LOGFN emptied. Logging."
while true; do date "+%F %T" | tee -a "$LOGFN"; df | egrep DATAEXT\|Avail\|LIN\|disk2s1 | tee -a "$LOGFN"; sleep 0.1; done;
