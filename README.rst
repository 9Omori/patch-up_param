up_param patcher
================

How does it work?
-----------------

The ‘up_param’ partition on Samsung phones is a .TAR archive that stores
images used on boot:

``adb shell dd if=/dev/block/by-name/up_param status=none | file -``

Output: ``/dev/stdin: POSIX tar archive (GNU)``

The ‘svb_orange.jpg’ and ‘booting_warning.jpg’ are the images
responsible for the ‘bootloader unlocked’ warning:

``adb shell 'dd if=/dev/block/by-name/up_param' | tar -x svb_orange.jpg booting_warning.jpg -C /tmp; eog /tmp/{svb_orange,booting_warning}.jpg``

This module extracts the ‘up_param’ partition, removes those files,
re-archives ‘up_param’ and flashes the partition

Requirements:
-------------

-  A Samsung phone rooted with KernelSU or Magisk

Tested on:
----------

-  Galaxy S10 - 'beyond1lte' (Exynos, CherishOS 5.1/14, Magisk) - ✅ Working

Installation:
-------------

-  Download the .ZIP release file
-  Flash the .ZIP file in KernelSU/Magisk
-  Reboot

Uninstallation:
---------------

`uninstall.sh` is currently not working, so
at the moment this module's patching is
permanent and irrevisbile. Please be careful
using it.

Recovery:
---------

(If something goes wrong with patching up_param.)

(SAMFW)
~~~~~~~

-  Go to ‘https://samfw.com/’
-  Search for your device model
-  Select your country and then your mirror
-  Select the latest download option
-  Download (this may take a while)
-  Extract the ‘up_param.bin.lz4’ file from the BL.tar file:

   -  ``tar -xf BL_*.tar up_param.bin.lz4``

-  Reboot your device to recovery mode

- Enable ADB (CWM recoveries only)

-  Decompress and flash the up_param file:

   -  ``unlz4 -c -k ./up_param.bin.lz4 | adb shell dd of=/dev/block/by-name/up_param``

-  Reboot to system:

   -  ``adb reboot system``
