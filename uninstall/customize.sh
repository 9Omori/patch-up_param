#!/sbin/sh

ui_print "- Uninstalling patch-up_param"
{
    if [ -d "/data/adb/modules/samsung_up_param_patcher" ]; then
        cd /data/adb/modules/samsung_up_param_patcher
        ui_print "- Extracting up_param"
        mkdir up_param || rm -rf up_param/*
        dd if=/dev/block/by-name/up_param | tar -x -C up_param
        cd up_param
        ui_print "- Retrieving old boot images"
        wget https://raw.githubusercontent.com/9Omori/patch-up_param/master/{svb_orange,booting_warning}.jpg
        ui_print "- Uploading up_param"
        tar -cf - * | dd of=/dev/block/by-name/up_param
        cd ../..
        ui_print "- Removing up_param Patcher directory"
        rm -rf samsung_up_param_patcher
    else
        abort "- up_param Patcher is not installed!"
    fi
}
