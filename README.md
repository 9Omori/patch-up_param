# up_param patcher

### How does it work?
The 'up_param' partition on Samsung phones is a .TAR archive that stores images used on boot:\n
`adb shell dd if=/dev/block/by-name/up_param status=none | file -`\n
Output: `/dev/stdin: POSIX tar archive (GNU)`\n
The 'svb_orange.jpg' and 'booting_warning.jpg' are the images responsible for the 'bootloader unlocked' warning\n
This module extracts the 'up_param' partition, removes those files, re-archives 'up_param' and flashes the partition

## Requirements:
- A Samsung phone rooted with KernelSU or Magisk

## Installation:
- Download the .ZIP release file
- Flash the .ZIP file in KSU/Magisk
- Reboot

## Uninstallation:
### (The 'uninstall.sh' script is currently not working, hence manual uninstallation is required.)
- Enable USB debugging & connect your device to a computer with ADB
- Run:
  * `adb root`
  * `adb shell dd if=/data/adb/modules/samsung_up_param_patcher/original-up_param.tar of=/dev/block/by-name/up_param`
- Reboot

## Recovery:
### (If something goes wrong with patching up_param.)
- Go to 'https://samfw.com/'
- Search for your device model
- Select your country
- Select the latest download option
- Download (this may take a while)
- Extract the 'up_param.bin.lz4' file from the BL.tar file:
  * `tar -xf BL_*.tar up_param.bin.lz4`
- Decompress the 'up_param.bin.lz4' file:
  * `unlz4 up_param.bin.lz4`
- Reboot your device to recovery mode & enable ADB (for CVM-recovery only)
- Push the up_param file:
  * `adb push up_param.bin /sdcard`
- Flash the up_param file:
  * `adb shell dd if=/sdcard/up_param.bin of=/dev/block/by-name/up_param`
- Reboot to system:
  * `adb reboot system`
