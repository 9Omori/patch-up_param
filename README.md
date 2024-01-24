### up_param patcher

## How does it work?
# The 'up_param' partition on Samsung phones is a .TAR archive that stores images used on boot
# The 'svb_orange.jpg' and 'booting_warning.jpg' are the images responsible for the 'bootloader unlocked' warning
# This module extracts the 'up_param' partition, removes those files, re-archives 'up_param' and flashes the partition

## Requirements:
# - A Samsung phone rooted with KernelSU or Magisk

## Installation:
# (1) Download the .ZIP release file
# (2) Flash the .ZIP file in KSU/Magisk
# (3) Reboot

## Uninstallation:
# (The 'uninstall.sh' script is currently not working, hence manual uninstallation is required.)
# (1) Enable USB debugging & connect your device to a computer with ADB
# (2) Run:
#     `adb root`
#     `adb shell dd if=/data/adb/modules/samsung_up_param_patcher/original-up_param.tar of=/dev/block/by-name/up_param`
# (3) Reboot

## Recovery:
# (If something goes wrong with patching up_param.)
# (1) Go to 'https://samfw.com/'
# (2) Search for your device model
# (3) Select your country
# (4) Select the latest download option
# (5) Download (this may take a while)
# (6) Extract the 'BL_XXXXX_XXXXX_XXXXX_XXXXX.tar' file
# (7) Extract the 'up_param.bin.lz4' file from the BL.tar file
# (8) Decompress the 'up_param.bin.lz4' file:
#     `unlz4 up_param.bin.lz4`
# (9) Reboot your device to recovery mode & enable ADB
# (10) Push the up_param file:
#     `adb push up_param.bin /sdcard`
# (11) Flash the up_param file:
#     `adb shell dd if=/sdcard/up_param.bin of=/dev/block/by-name/up_param`
# (12) Reboot to system
