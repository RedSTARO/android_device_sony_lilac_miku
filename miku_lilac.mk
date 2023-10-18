$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit device configuration
$(call inherit-product, device/sony/lilac/device.mk)

# Product API level
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o.mk)

## BOOTANIMATION
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

TARGET_BOOTANIMATION_HALF_RES := true


#inhert some common miku stuff
$(call inherit-product, vendor/miku/build/product/miku_product.mk)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := miku_lilac
PRODUCT_DEVICE := lilac
PRODUCT_BRAND := Sony
PRODUCT_MODEL := G8441
PRODUCT_MANUFACTURER := Sony

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=lilac \
    PRIVATE_BUILD_DESC="G8441-user 9 47.2.A.11.228 3311891731 release-keys"

BUILD_FINGERPRINT := Sony/G8441/G8441:9/47.2.A.11.228/3311891731:user/release-keys
<<<<<<< HEAD

## Modified for miku
# MIKU_GAPPS := true
MIKU_MASTER := RedSTAR
=======
>>>>>>> parent of 56f09d3 (Use r450784d instead of proton clang)
