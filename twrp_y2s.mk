# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/y2s/device.mk)

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/samsung/y2s/recovery/root,recovery/root)

# Device identifier
PRODUCT_RELEASE_NAME := y2s
PRODUCT_DEVICE := y2s
PRODUCT_NAME := twrp_y2s
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := Galaxy S20+
PRODUCT_MANUFACTURER := samsung

