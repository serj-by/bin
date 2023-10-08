#! /usr/bin/env bash
. cdloc
echo "Home LocAmp dir: `pwd`"
cd dokuwiki
echo "DokuWiki dir: `pwd`"
gcm_noint "autoupdate dokuwiki on `sbdate` @ `sbtime`"
