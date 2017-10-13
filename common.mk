PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Include versioning information 
# Format: Major.minor.maintenance(-TAG) 
export CAF_VERSION := LA.UM.5.8.r1-02900-8x98.0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.require_network=any \
    ro.setupwizard.mode=OPTIONAL \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true \
    ro.caf.version=$(shell grep "<default revision=" .repo/manifest.xml | awk -F'"' '{print $$2}' | awk  -F "/" '{print $$3}') \
    ro.pa-caf.version=$(shell grep "/PA-CAF" -A1 .repo/manifest.xml | tail -1 | awk -F'"' '{print $$2}' | awk -F "/" '{print $$3}')

PRODUCT_PROPERTY_OVERRIDES += ro.build.selinux=1

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aosp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aosp/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/aosp/prebuilt/common/bin/whitelist:system/addon.d/whitelist \

# Bootanimation
PRODUCT_COPY_FILES += vendor/aosp/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# init.d support
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/aosp/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aosp/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init.local.rc:root/init.local.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/aosp/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/aosp/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Browser \
    Jelly \
    libemoji \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    busybox \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Terminal \
    WallpaperPicker \
    ParanoidPapers \
    Launcher3 \
    Mms

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk

# telephony related functionalities to work.
PRODUCT_PACKAGES += telephony-ext

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface

# RCS
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Snapdragon packages
PRODUCT_PACKAGES += \
    MusicFX \
    SnapdragonCamera \
    SnapdragonGallery \
    SnapdragonMusic
    
# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

# OMS
PRODUCT_PACKAGES += ThemeInterfacer

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += SoundRecorder

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# World APN list
PRODUCT_COPY_FILES += vendor/aosp/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Don't Hide APNs
PRODUCT_PROPERTY_OVERRIDES += persist.sys.hideapn=false

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += vendor/aosp/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += vendor/aosp/overlay/common

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

#ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
#ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
#endif

# AOSPA services 
PRODUCT_PACKAGES += pa-services 
PRODUCT_PACKAGES += co.aospa.power.ShutdownAOSPA.xml 
PRODUCT_BOOT_JARS += pa-services 

# Copy PA specific init file
PRODUCT_COPY_FILES += vendor/aosp/prebuilt/common/root/init.pa.rc:root/init.pa.rc

$(call inherit-product-if-exists, vendor/extra/product.mk)

# Include proprietary header flags if vendor/head exists
-include vendor/head/head-capabilities.mk
