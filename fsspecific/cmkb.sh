#! /usr/bin/env bash
. cdloc
scpt_name=${0##*/}
echo "Home dir: `pwd` Script name: $scpt_name"
cd kanboard
echo "Kanboard dir: `pwd`"
gcm_noint "autoupdate kanboard at `sbdate` @ `sbtime`"
