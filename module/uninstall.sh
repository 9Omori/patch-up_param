#!/sbin/sh

# errexit -- exit on errors
set -o errexit

function restore
{
  RESTORE="$1"

  dd if=$RESTORE of=/dev/block/by-name/up_param || abort "- Failed to upload up_param!"
}

if (tar -tf "$MODPATH/up_param.tar" >/dev/null); then
  ui_print "- Using $MODPATH/up_param.tar"
  restore "$MODPATH/up_param.tar"
else
  ui_print "- No file to restore"
fi
