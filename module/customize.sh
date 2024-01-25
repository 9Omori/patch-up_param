#!/sbin/sh

ui_print "- Extracting up_param"
{
    if ! dd if=/dev/block/by-name/up_param status=none; then
        abort "- up_param not found! Is your device a Samsung phone?"
    fi
    if ! [ "$PWD" = "$MODPATH" ]; then
        [ -d "$MODPATH/tmp" ] || mkdir -p $MODPATH/tmp
        cd $MODPATH
    fi
    [ -d "./up_param" ] && rm -rf "./up_param"
    mkdir ./up_param
    dd if=/dev/block/by-name/up_param | tar -x -C ./up_param || abort "- Failed to extract up_param!"
    if ! [ -f "$MODPATH/original-up_param.tar" ]; then
        ui_print "- Creating backup of original up_param"
        dd if=/dev/block/by-name/up_param of=$MODPATH/original-up_param.tar
    fi
}

ui_print "- Patching up_param"
{
    cd $MODPATH/up_param
    for x in "svb_orange.jpg" "booting_warning.jpg"; do [ -f "${x}" ] && rm -f "${x}"; done
    rm -f *.tar
}

ui_print "- Uploading up_param"
{
    [ "${PWD##*/}" = "up_param" ] || cd up_param
    tar cf '-' * | dd of=/dev/block/by-name/up_param || abort "- Failed to upload up_param!"
}

ui_print "- Success"
