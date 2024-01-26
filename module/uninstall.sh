#!/sbin/sh

mkdir /data/adb/up_param
cd /data/adb/up_param

dd if=/dev/block/by-name/up_param status=none | tar -x -C .

curl -LO https://raw.githubusercontent.com/9Omori/patch-up_param/master/svb_orange.jpg
curl -LO https://raw.githubusercontent.com/9Omori/patch-up_param/master/booting_warning.jpg

tar cf - * | dd of=/dev/block/by-name/up_param

cd /data/adb
rm -rf up_param
