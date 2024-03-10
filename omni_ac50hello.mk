#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
# Copyright (C) 2024 Dawnowl444
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common_tablet.mk)

# Inherit from ac50hello device
$(call inherit-product, device/archos/ac50hello/device.mk)

# Device identifier
PRODUCT_DEVICE := ac50hello
PRODUCT_NAME := omni_ac50hello
