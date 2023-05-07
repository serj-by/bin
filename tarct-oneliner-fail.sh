#! /usr/bin/env bash
#ARCHNAME="ProtonVPN.app.tgz"
#DIRNAME="ProtonVPN.app"
DIRNAME="$1"
ARCHNAME="$1.tgz"
echo "ARCH..."; tar czvf $ARCHNAME $DIRNAME && echo "ARCH! TEST..."; tar tzvf $ARCHNAME && echo "TESTED!" || echo "FAILED..."
