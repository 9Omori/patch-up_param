#!/sbin/sh

cd /data/adb/modules/samsung_up_param_patcher
rm -rf up_param/* || mkdir up_param

cd up_param
dd if=/dev/block/by-name/up_param | tar -x -C .
cp ../svb_orange.jpg ../booting_warning.jpg .

tar -cf - * | dd if=/dev/block/by-name/up_param
