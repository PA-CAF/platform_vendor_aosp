# Charger
ifneq ($(WITH_CUSTOM_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.custom
endif

# QCOM HW crypto
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    TARGET_CRYPTFS_HW_PATH ?= vendor/qcom/opensource/cryptfs_hw
endif
