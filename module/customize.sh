#!/sbin/sh

extract ()
{
    if ! [ "$PWD" = "$MODPATH" ]; then
        [ -d "$MODPATH/tmp" ] || mkdir -p $MODPATH/tmp
        cd $MODPATH
    fi
    [ -d "./up_param" ] && rm -rf "./up_param"
    mkdir ./up_param
    dd if=/dev/block/by-name/up_param | tar -x -C ./up_param || abort "- Failed to extract up_param!"
}

patch ()
{
    cd $MODPATH/up_param
    for x in "svb_orange.jpg" "booting_warning.jpg"; do [ -f "${x}" ] && rm -f "${x}"; done
    rm -f *.tar
}

upload ()
{
    [ "${PWD##*/}" = "up_param" ] || cd up_param
    tar cf '-' * | dd of=/dev/block/by-name/up_param || abort "- Failed to upload up_param!"
}

if ! dd if=/dev/block/by-name/up_param status=none &>/dev/null; then
    abort "- up_param not found! Is your device a Samsung phone?"
fi

if ! [[ "$(dd if=/dev/block/by-name/up_param status=none | tar tf)" =~ "svb_orange.jpg" ]]; then
    ui_print "- up_param already patched, not patching again."
else
    ui_print "- Extracting up_param" ; extract
    ui_print "- Patching up_param"   ; patch
    ui_print "- Uploading up_param"  ; upload
fi

ui_print "- Success"
