#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/boost-framework/com.qualcomm.qti.Performance.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.qualcomm.qti.Performance.xml \
	$(LOCAL_PATH)/boost-framework/com.qualcomm.qti.UxPerformance.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.qualcomm.qti.UxPerformance.xml

# Perf 
PRODUCT_BOOT_JARS += \
    QPerformance \
    UxPerformance

# Perf (TensorFlow)
PRODUCT_PACKAGES += \
    libtflite

# PSI
PRODUCT_PACKAGES += \
    libpsi.vendor

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0 \
    vendor.qti.hardware.perf@2.3