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

``adb shell 'dd if=/dev/block/by-name/up_param' | tar -x svb_orange.jpg booting_warning.jpg -C /tmp; eog /tmp/{svb_orange.jpg,booting_warning.jpg}``

This module extracts the ‘up_param’ partition, removes those files,
re-archives ‘up_param’ and flashes the partition

Requirements:
-------------

-  A Samsung phone rooted with KernelSU or Magisk

Tested on:
----------

-  Galaxy S10 (Exynos, CherishOS 5.1/14, Magisk) - ✅ Working

Installation:
-------------

-  Download the .ZIP release file
-  Flash the .ZIP file in KSU/Magisk
-  Reboot

Uninstallation:
---------------

Uninstallation should be automatic (through uninstall.sh), but in case
of failure, run the following: - Enter ADB shell: \* ``adb shell`` -
Write original up_param.tar \* ``cd /data/adb/modules/up_param-patcher``
\* ``dd if=up_param.tar of=/dev/block/by-name/up_param``

Recovery:
---------

(If something goes wrong with patching up_param.)

(Prebuilt)
~~~~~~~~~~

-  Go to the releases section
-  Check if your model is there (‘up_param-MODEL.tar’)
-  Download the archive ### (Manual)
-  Go to ‘https://samfw.com/’
-  Search for your device model
-  Select your country
-  Select the latest download option
-  Download (this may take a while)
-  Extract the ‘up_param.bin.lz4’ file from the BL.tar file:

   -  ``tar -xf BL_*.tar up_param.bin.lz4``

-  Decompress the ‘up_param.bin.lz4’ file:

   -  .. rubric:: ``unlz4 up_param.bin.lz4``
         :name: unlz4-up_param.bin.lz4

-  Reboot your device to recovery mode & enable ADB (for CVM-recovery
   only)
-  Flash the up_param file:

   -  ``dd if=./up_param.bin status=none | adb shell dd of=/dev/block/by-name/up_param``

-  Reboot to system:

   -  ``adb reboot system``
