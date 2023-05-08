#! /usr/bin/env bash
. cdloc
echo "Home dir: `pwd`"
cd dokuwiki
echo "DokuWiki dir: `pwd`"
gcm_noint "autoupdate dokuwiki at `sbdate` @ `sbtime`"
