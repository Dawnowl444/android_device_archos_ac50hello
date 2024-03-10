# TWRP device tree for Archos Hello 5 (ac50hello)

***

## Device tree updated and cleaned with https://github.com/twrpdtgen/twrpdtgen

***

# Develloppement status :

### Blocking checks
- [x] Correct screen/recovery size
- [x] Working Touch, screen
- [x] Backup to internal/microSD
- [x] Restore from internal/microSD
- [x] reboot to system
- [x] ADB

#### Medium checks
- [x] update.zip sideload
- [x] UI colors (red/blue inversions)
- [x] Correct screen orientation
- [x] Screen goes off and on
- [x] F2FS/EXT4 Support, exFAT/NTFS where supported
- [x] all important partitions listed in mount/backup lists
- ~~backup/restore to/from external (USB-OTG) storage~~
- [x] backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)
- [ ] decrypt /data
- [x] Correct date

### Minor checks
- [x] MTP export
- [x] reboot to bootloader
- [x] reboot to recovery
- [x] poweroff
- [x] battery level
- [x] temperature
- [x] encrypted backups
- ~~input devices via USB (USB-OTG) - keyboard, mouse and disks~~
- [x] USB mass storage export
- [x] set brightness
- ~~vibrate~~
- [x] screenshot
- [x] partition SD card

***

# Miscellaneous :

## How to compile TWRP :
```bash
croot; export ALLOW_MISSING_DEPENDENCIES=true; export PATH=$PWD/bin:$PATH; source build/envsetup.sh; lunch omni_ac50hello-userdebug; mka clean; mka recoveryimage
```
#### If you get a SyntaxError from Python this may mean that your /bin/python is Python3 but Android 8.1 needs Python2, so do this then rebuild
> <https://wiki.archlinux.org/index.php?title=Android&oldid=725613>

## ***Unsigned*** Stock rom extracted by none other than me :
> <https://drive.google.com/file/d/1xBjN4QrCB_QOoR1nHTn25CGDdWrMkYng/view?usp=sharing>

## Thanks :
>- <https://forum.xda-developers.com/t/guide-porting-twrp-without-source.3843473/> ❤️❤️❤️ for making possible to make kind of an initial draft of porting TWRP
>- <https://github.com/imasaru/android_device_tree_template> ❤️❤️ for the beginner script
>- <https://github.com/wadimaks/android_device_mediatek_mt6580/> ❤️ for informations and flags (TARGET_USE_CUSTOM_LUN_FILE_PATH, TW_CUSTOM_CPU_TEMP_PATH...) for the mt6580
>- <http://forum.xda-developers.com/showthread.php?p=32965365> basis for how to port and compile TWRP
>- <https://github.com/ShivamKumarJha/android_tools> script to make proprietary-files.txt and vendor_prop.mk

***

# About Device

![Archos Hello 5](https://www.archos.com/wp-content/images/products/hello_5-300.png "Archos Hello 5 (ac50hello)")

Component | Specs
---|:---:
Chipset | MediaTek MT6580
CPU | ARM Cortex-A7, Quad-Core, 1.3GHz
GPU | ARM Mali-400 MP, 500MHz
Memory  | 2GB (soldered)
Shipped Android Version | 8.1 (Oreo)
Storage | 16GB eMMC
MicroSD | Up to 128 GB
Battery | 3000 mAh, Li-Ion (non-removable)
Display | Landscape 1280x720 pixels, 5"
Front Camera | 5.0 MP + Physical obturation system
Rear Camera  | N/A
Wifi | 2.4GHz
Cellular | N/A
Bluetooth | v4.0 BLE
GPS | Yes
Vibration Motor | N/A
USB | Micro USB, __No OTG__
Release Date | 2018
Treble Compatibility | ARM 32-bit, A-only
