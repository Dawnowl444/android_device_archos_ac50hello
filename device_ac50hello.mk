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


# Put fr_FR first in the list, so make it default
PRODUCT_LOCALES := fr_FR # 🇫🇷

# Build configuration for the barebone of Android AOSP. The rest shall be inherit from Lineage or Omni or else
ifeq ($(TARGET_IS_64_BIT), true)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk) # arm64 compatibility layer
    $(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk) # arm32 base wich is not called by core_64, go figure
else
	#SANITIZE_LITE := true # should force creation of 32 symlinks like app_process32
    $(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk) # arm32 base
endif

# Build configuration for Treble support
#$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_arm_a.mk)

# Build configuration for GSM features
#$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

# Build configuration for Android Go features https://www.android.com/versions/go-edition/
#$(call inherit-product, $(SRC_TARGET_DIR)/product/go_defaults.mk) # ain't working, need more configuration 

# Build configuration for full Android AOSP
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit vendor blobs
$(call inherit-product-if-exists, vendor/archos/ac50hello/ac50hello-vendor.mk)

# Device identifier
PRODUCT_DEVICE := ac50hello
PRODUCT_NAME := full_ac50hello
PRODUCT_MODEL := Archos Hello 5
PRODUCT_BRAND := 🏳‍🌈
PRODUCT_MANUFACTURER := Trans Rights 🏳‍⚧ !

# Define screen size for prebuilt apps
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_AAPT_CONFIG := hdpi 560dpi mdpi 480dpi

# Screen size for boot animation
TARGET_SCREEN_HEIGHT := 720
TARGET_SCREEN_WIDTH := 1280


# Product specifications
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.hwrotation=90
$(call inherit-product, device/archos/ac50hello/vendor_prop.mk) # Inherit vendor configuration


# As of this March 14, 2017 announcement, the Jack toolchain is deprecated. Jack was the default Android build toolchain for Android 6.0–8.1 https://source.android.com/setup/build/jack
# Plus it's buggy as hell and use TLSv1 https://stackoverflow.com/questions/67330554/is-openjdk-upgrading-to-8u292-break-my-aosp-build-system
ANDROID_COMPILE_WITH_JACK := false
