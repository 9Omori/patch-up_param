#!/sbin/sh

cd /data/adb/modules/samsung_up_param_patcher
dd if=original-up_param.tar of=/dev/block/by-name/up_param
