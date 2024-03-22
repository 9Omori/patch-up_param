#!/sbin/sh

# errexit -- exit on errors
set -o errexit

function extract
{
  ui_print "- Extracting up_param"

  if [ "$PWD" != "$MODPATH" ]; then
    cd $MODPATH
    if [ ! -d tmp ]; then
      mkdir -pv tmp
    fi
  fi

  if [ -d up_param ]; then
    ui_print "- Removing existing up_param folder"
    rm -rfv ./up_param
  fi
  mkdir up_param

  dd if=/dev/block/by-name/up_param | tar -x -C ./up_param || abort "- Failed to extract up_param!"

  tar -cf up_param.tar up_param
  mv up_param.tar $MODPATH
}

function patch
{
  ui_print "- Patching up_param"

  cd "$MODPATH/up_param"
  for target in svb_orange.jpg booting_warning.jpg; do
    if [ -f "$target" ]; then
      rm -f "$target" && ui_print "- Removed $target"
    fi
  done
  rm -fv *.tar
}

function upload
{
  ui_print "- Uploading up_param"

  if ! [ "${PWD##*/}" == "up_param" ]; then
    cd up_param
  fi
  tar -cf '-' * | dd of=/dev/block/by-name/up_param || abort "- Failed to upload up_param!"
}

if (! dd if=/dev/block/by-name/up_param status=none >/dev/null); then
  abort "- up_param not found! Module can only be used on Samsung phones"
fi

if (! dd if=/dev/block/by-name/up_param status=none | tar -t | grep -q -F "svb_orange.jpg"); then
  ui_print "- up_param already patched, not patching again"
else
  extract
  patch
  upload
fi
