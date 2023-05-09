#! /usr/bin/env bash

scpt_name=${0##*/};
COMMENT="autobackup in $scpt_name";


if [[ "$@" != "" ]]; then
    COMMENTPARAMS="$@ commitall on `sbdate` `sbtime`"
    COMMENT="`echo -n $COMMENTPARAMS | tr -c '[[:alnum:]]' '_'`"
fi
echo "Comment to commit: $COMMENT";

. cmkb.sh $COMMENT
. cmwiki.sh $COMMENT
. cmdevinf.sh $COMMENT

echo "Commited every docs `sbdate` @ `sbtime`";
echo "Start backing up synthes...";
bksynt --doit $COMMENT

#read -p "Press enter to continue..." dummyvar
keypress.sh
