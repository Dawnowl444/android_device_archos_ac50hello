#
#	Copyright (C) 2021 Dawnowl444
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Platform
BOARD_VENDOR := archos
TARGET_BOARD_PLATFORM := mt6580
TARGET_BOARD_PLATFORM_GPU := mali-400 MP
TARGET_NO_BOOTLOADER := true # whether or not to build the bootloader (only if we have bootloader source)
TARGET_BOOTLOADER_BOARD_NAME := ac50hello

# Architecture
TARGET_IS_64_BIT := false
TARGET_USES_64_BIT_BINDER := false
ifeq ($(TARGET_IS_64_BIT), true)
	TARGET_ARCH := arm64
	TARGET_ARCH_VARIANT := armv8-a
	TARGET_CPU_ABI := arm64-v8a
	TARGET_CPU_ABI2 :=
	TARGET_CPU_VARIANT := cortex-a53

	# Secondary Architecture
	TARGET_2ND_ARCH := arm
	TARGET_2ND_ARCH_VARIANT := armv7-a-neon
	TARGET_2ND_CPU_ABI := armeabi-v7a
	TARGET_2ND_CPU_ABI2 := armeabi
	TARGET_2ND_CPU_VARIANT := cortex-a53
	TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI)
	TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI),$(TARGET_2ND_CPU_ABI2)
	TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_64_BIT),$(TARGET_CPU_ABI_LIST_32_BIT)
else
	TARGET_ARCH := arm
	TARGET_ARCH_VARIANT := armv7-a-neon
	TARGET_CPU_ABI := armeabi-v7a
	TARGET_CPU_ABI2 := armeabi
	TARGET_CPU_VARIANT := cortex-a7
	TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI),$(TARGET_CPU_ABI2)
endif

# MTK Chipsets only
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true
MTK_BOARD_PLATFORMS := $(TARGET_BOARD_PLATFORM)

# Kernel Source → uncomment if you want to build from source → not working
#TARGET_KERNEL_ARCH := arm
#TARGET_KERNEL_HEADER_ARCH := arm
#TARGET_KERNEL_SOURCE := kernel/wiko/lenny_3
#TARGET_KERNEL_CONFIG := v3702_defconfig #lenny_3 config file
#TARGET_KERNEL_CONFIG := ac50hello_defconfig
#CROSS_COMPILE := prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin/arm-eabi-
#MTK_PLATFORM := $(TARGET_BOARD_PLATFORM)

# Prebuilt kernel
TARGET_PREBUILT_KERNEL := device/archos/ac50hello/prebuilt/zImage.kernel #stock kernel
# For ARM use: zImage, for ARM64 use: Image.gz, for uncompressed use: Image. If using an appended DT, append '-dtb' to the end of the image name. For example, for ARM devices use zImage-dtb
BOARD_KERNEL_IMAGE_NAME := zImage-dtb


# File systems
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216 #0x1000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216 #0x1000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12848726016 #0x2FDD80000
BOARD_CACHEIMAGE_PARTITION_SIZE := 117440512 #0x7000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648 #0x80000000
BOARD_HAS_LARGE_FILESYSTEM := true # if there is a partition larger than 2GB

# Image
BOARD_KERNEL_CMDLINE := bootopt=64S3,32S1,32S1 
BOARD_KERNEL_BASE := 0x80000000
BOARD_NAME := $(TARGET_BOOTLOADER_BOARD_NAME)
BOARD_PAGE_SIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x04000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_KERNEL_TAGS_OFFSET := 0x0e000000
BOARD_BOOTIMG_HEADER_VERSION := 0
BOARD_FLASH_BLOCK_SIZE := 0x20000
BOARD_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE) --pagesize $(BOARD_PAGE_SIZE) --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --board $(BOARD_NAME)
#BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION) # Android 9 🥧 and above

# Display
#TARGET_RECOVERY_PIXEL_FORMAT := # RGB_565 or BGRA_8888 or RGBA_8888 or RGBX_8888
#TW_NO_SCREEN_BLANK := true
#TW_SCREEN_BLANK_ON_BOOT := true # If the screen only kick in to action AFTER it has gone to sleep once and has been woken up
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 170

# TWRP recovery
RECOVERY_VARIANT := twrp
TW_THEME := landscape_hdpi
DEVICE_RESOLUTION := 720x1280
#BOARD_HAS_NO_REAL_SDCARD := true # disables things like sdcard partitioning and may save you some space if TWRP isn't fitting in your recovery patition
#TW_EXTRA_LANGUAGES := false # may save you some space if TWRP isn't fitting in your recovery patition
#TW_DEFAULT_LANGUAGE := fr # 🇫🇷
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_SUPERSU := true # Remove SuperSU and stop TWRP prompts to install it
TW_INCLUDE_NTFS_3G := true # Include NTFS Filesystem Support
TW_INCLUDE_FUSE_EXFAT := true # Include ExFAT Filesystem Support
TW_INCLUDE_CRYPTO := true # Add Data Encryption Support or not
TW_INCLUDE_FBE := true
#TW_INCLUDE_CRYPTO_FBE := true # Running Android 10 and higher https://source.android.com/security/encryption/file-based
#TW_USE_TOOLBOX := true # to use ToolBox wich avoid errors from BusyBox
TW_USE_TOYBOX := true # should make use of ToyBox rather than BusyBox or ToolBox which are deprecated
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

# MT6580 specific
TW_SECONDARY_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
TW_CUSTOM_CPU_TEMP_PATH := /sys/class/thermal/thermal_zone1/temp # mtktscpu
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file
BOARD_USES_METADATA_PARTITION := true

# Force landscape
TW_ROTATION := 90
RECOVERY_TOUCHSCREEN_SWAP_XY := true
RECOVERY_TOUCHSCREEN_FLIP_Y := true

# Crypto
TW_CRYPTO_FS_TYPE := f2fs
TW_CRYPTO_REAL_BLKDEV := /dev/block/platform/mtk-msdc.0/11120000.msdc0/by-name/userdata
TW_CRYPTO_MNT_POINT := /data
TW_CRYPTO_FS_OPTIONS := noatime,nosuid,nodev,discard,noflush_merge
TW_CRYPTO_KEY_LOC := /dev/block/platform/mtk-msdc.0/11120000.msdc0/by-name/metadata