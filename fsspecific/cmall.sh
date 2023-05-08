. cdloc
scpt_name=${0##*/}
echo "Home dir: `pwd` Script name: $scpt_name"
cd kanboard
echo "Kanboard dir: `pwd`"
gcm_noint "autoupdate kanboard at `sbdate` @ `sbtime`"

. cdloc
echo "Home dir: `pwd`"
cd dokuwiki
echo "DokuWiki dir: `pwd`"
gcm_noint "autoupdate dokuwiki at `sbdate` @ `sbtime`"

. cddevinfo
echo "Dev/_info dir: `pwd`"
gcm_noint "autoupdate devinfo at `sbdate` @ `sbtime`"


echo "Commited every docs `sbdate` @ `sbtime`";
bksynt --doit "autobackup in $scpt_name"

read -p "Press enter to continue..." dummyvar
