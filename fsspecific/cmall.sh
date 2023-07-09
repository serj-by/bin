#! /usr/bin/env bash

scpt_name=${0##*/};
COMMENT="autobackup in $scpt_name";


if [[ "$@" != "" ]]; then
    COMMENTPARAMS="$@ commitall on `sbdate` `sbtime`"
    COMMENT="`echo -n $COMMENTPARAMS | tr -c '[[:alnum:]]' '_'`"
fi
echo "@cmall.sh: Comment to commit: $COMMENT";

. cmkb.sh $COMMENT
. cmwiki.sh $COMMENT
. cmdevinf.sh $COMMENT

echo "@cmall.sh: Commited every docs `sbdate` @ `sbtime`";
echo "@cmall.sh: Start backing up synthes...";
bksynt --doit $COMMENT

#read -p "Press enter to continue..." dummyvar
keypress.sh
