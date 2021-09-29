# ~~Lineage OS 15.1 building~~ **Not booting**
## (It appears that I don't have the skill set necessary to fully understand how to compile a working kernel nor a working image of Lineage. Building LineageOS with stock kernel error me out with missing kernel headers. Therefore I attempted to build kernel and LineageOS from stock ac50hello Defconfig and with Wiko Lenny 3 sources, but after long trial and error, those images still refused to boot. So I gave up, but, if you want to continue where I left, be my guest. But in the meantime Project Treble image works so why bother...)

##### First create .repo/local_manifests/ac50hello.xml with this, and then repo sync
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	<!-- TWRP git but this will error you out missing depencies. It's on you to fix it or to not build TWRP while building LineageOS -->
	<project name="omnirom/android_bootable_recovery" path="bootable/recovery-twrp" remote="github" revision="android-9.0" />
	<!-- busybox git from OmniRom, the git from Lineage OS stopped development after Android 7.1 and CyanogenMod 14.1 (RIP) -->
	<!-- <project name="omnirom/android_external_busybox" path="external/busybox" remote="github" revision="android-8.1" /> -->
	<!-- kernel 3.x git credit to its owner Mysteryagr -->
	<project name="Mysteryagr/MT6580-Kernel-3.18" path="kernel/wiko/lenny_3" remote="github" revision="master" />
	<!-- stock recent kernel git from google aosp for testing -->
	<project name="kernel/common" path="kernel/archos/ac50hello" remote="android.googlesource" revision="android-4.9-o" />
	<!-- toolchain git from google aosp -->
	<project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" remote="android.googlesource" revision="master" />
</manifest>
```

##### If you get missing depencies errors from recovery, comment out the use of TWRP in device/archos/ac50hello/BoardConfig.mk
```mk
#RECOVERY_VARIANT := twrp
```

##### If you get __'out/target/product/ac50hello/system/bin/app_process32', needed by 'out/target/product/ac50hello/system/bin/app_process', missing and no known rule to make it__ error execute this plus change LOCAL_MODULE line of Android.mk to app_process32
```bash
croot; mv frameworks/base/cmds/app_process frameworks/base/cmds/app_process32
```

## How to compile LineageOS :
```bash
croot; export PATH=$PWD/bin:$PATH; source build/envsetup.sh; cd kernel/wiko/lenny_3; make clean; make mrproper; croot; breakfast lineage_ac50hello-eng; mka clean; brunch lineage_ac50hello-eng
```

## Building kernel from source

##### Manually compile 3.18.x kernel from Wiko Lenny 3 (credit to Mysteryagr)
```bash
croot; source build/envsetup.sh; cp device/archos/ac50hello/prebuilts/ac50hello_defconfig kernel/wiko/lenny_3/arch/arm/configs/; cd kernel/wiko/lenny_3; ln -s ../../../prebuilts ./; export CROSS_COMPILE=prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin/arm-eabi-; export EXTRA_CMDS='bootopt=64S3,32S1,32S1'; export ARCH=arm; export ARCH_MTK_PLATFORM=mt6580; make clean; make mrproper; make v3702_defconfig; make
```
##### If you get __multiple definition of yylloc__ error edit scripts/dtc/dtc-lexer.lex.c_shipped
```c
-YYLTYPE yylloc;
+extern YYLTYPE yylloc;
```
> <https://forum.xda-developers.com/t/multiple-definitions-in-dtc-error-when-trying-to-build-android-kernel.4123549/post-82951315>

##### If you get __fatal error: mt_cpufreq.h: No such file or directory__ and so on
```bash
cp drivers/misc/mediatek/base/power/mt6580/mt_cpufreq.h drivers/misc/mediatek/base/power/include/; cp drivers/misc/mediatek/base/power/mt6580/mt_gpufreq.h drivers/misc/mediatek/base/power/include/; cp drivers/misc/mediatek/btcvsd/AudioBTCVSDDef.h drivers/misc/mediatek/btcvsd/inc/mt6580/; cp drivers/misc/mediatek/cmdq/v2/mt6580/cmdq_engine.h drivers/misc/mediatek/cmdq/v2/; cp drivers/misc/mediatek/gpio/mt6580/*.h drivers/misc/mediatek/include/mt-plat/; cp drivers/misc/mediatek/i2c/mt6580/*.h drivers/misc/mediatek/include/; cp drivers/misc/mediatek/m4u/mt6580/*.h drivers/misc/mediatek/m4u/mt6580/../2.0/; cp drivers/misc/mediatek/power/mt6580/*.h drivers/misc/mediatek/include/; cp drivers/misc/mediatek/uart/mt6580/*.h drivers/misc/mediatek/uart/include/; cp drivers/misc/mediatek/video/mt6580/dispsys/*.h drivers/misc/mediatek/video/mt6580/videox/; cp drivers/misc/mediatek/video/mt6580/videox/*.h drivers/misc/mediatek/video/common/; cp drivers/mmc/host/mediatek/mt6580/*.h drivers/misc/mediatek/include/mt-plat/; cp drivers/pinctrl/mediatek/*.h include/; cp drivers/spi/mediatek/mt6580/*.h include/; cp drivers/watchdog/mediatek/wdt/mt6580/*.h include/

```