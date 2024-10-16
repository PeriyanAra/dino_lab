#!/bin/sh
CWD=$(pwd)

rm -rf $CWD/.git/hooks
mkdir -p $CWD/.git/hooks

cp $CWD/scripts/pre_push_hook.sh $CWD/.git/hooks/pre-push

chmod +x $CWD/.git/hooks/pre-push
