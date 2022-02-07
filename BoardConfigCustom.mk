#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc
TARGET_KERNEL_ADDITIONAL_FLAGS += LLVM=1
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := redbull_defconfig
TARGET_KERNEL_SOURCE := kernel/google/redbull
TARGET_NEEDS_DTBOIMAGE := true
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-gnu-

# Kernel modules
BOOT_KERNEL_MODULES += \
    heatmap.ko \
    touch_offload.ko

KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat device/google/redbull/modules.load))
KERNEL_MODULES_LOAD := $(foreach m,$(KERNEL_MODULES_LOAD_RAW),$(notdir $(m)))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(filter-out $(BOOT_KERNEL_MODULES), $(KERNEL_MODULES_LOAD))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(filter $(BOOT_KERNEL_MODULES), $(KERNEL_MODULES_LOAD))

# Manifests
DEVICE_MANIFEST_FILE += device/google/redbull/lineage_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/aosp/config/device_framework_matrix.xml

# Partitions
AB_OTA_PARTITIONS += \
    vendor

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# SELinux
BOARD_SEPOLICY_DIRS += device/google/redbull/sepolicy-custom/dynamic
BOARD_SEPOLICY_DIRS += device/google/redbull/sepolicy-custom/vendor

# Verified Boot
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
