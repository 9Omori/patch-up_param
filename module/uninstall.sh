#!/sbin/sh

[ "$PWD" = "$MODPATH" ] || cd $MODPATH
[ -f "./original-up_param.tar" ] && dd if=./original-up_param.tar of=/dev/block/by-name/up_param
