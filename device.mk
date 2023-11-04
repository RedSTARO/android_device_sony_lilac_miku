### PLATFORM
$(call inherit-product, device/sony/yoshino-common/platform.mk)
### PROPRIETARY VENDOR FILES
$(call inherit-product, vendor/sony/lilac/lilac-vendor.mk)

ifeq ($(WITH_FDROID),true)
$(call inherit-product, vendor/fdroid/fdroid-vendor.mk)
endif
ifeq ($(WITH_MICROG),true)
$(call inherit-product, vendor/microg/microg-vendor.mk)
endif

DEVICE_PATH := device/sony/lilac

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    vendor/qcom/perf

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-miku

### POWER
TARGET_USE_CUSTOM_POWERHINT := true

### Permissions
$(call inherit-product, $(LOCAL_PATH)/android/permissions/boost_framework_permissions.mk)

### import all .mk file in device/
include $(DEVICE_PATH)/device/*.mk

### Miku
MIKU_MASTER := RedSTAR
TARGET_WITH_KERNEL_SU := true

# Via browser only need if no Gapps (Chrome)
MIKU_GAPPS ?= false
ifeq ($(MIKU_GAPPS), false)
    PRODUCT_PACKAGES += Via
endif

