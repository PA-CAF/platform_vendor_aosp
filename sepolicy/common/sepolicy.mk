#
# This policy configuration will be used by all products that
# inherit from Vendor
#

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    vendor/custom/sepolicy/common/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/custom/sepolicy/common/private

BOARD_SEPOLICY_DIRS += \
    vendor/custom/sepolicy/common/vendor
