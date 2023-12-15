#!/system/bin/sh

MODPATH=${0%/*}
ORIGINAL_BOOT=$MODPATH/AutoBoot-Backup/backup_boot.img

# Load functions
. $MODPATH/scripts/util_functions.sh
get_flags
find_boot_image
flash_image $ORIGINAL_BOOT "$BOOTIMAGE"