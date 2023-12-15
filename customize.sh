##############
# Preparation
##############

# Default permissions

SCRIPTSDIR=$MODPATH/scripts
BACKUP_DIR="$MODPATH/AutoBoot-Backup"
mkdir -p "$BACKUP_DIR"
set_perm_recursive $SCRIPTSDIR 0 2000 0755 0755
# # Load utility functions
# . $SCRIPTSDIR/util_functions.sh

# setup_flashable
ui_print "Magisk Autoboot Installer"
get_flags
find_boot_image

[ -z $BOOTIMAGE ] && abort "! Unable to detect target image"
ui_print "- Target image: $BOOTIMAGE"

# Detect version and architecture
api_level_arch_detect
[ $API -lt 23 ] && abort "! Magisk only support Android 6.0 and above"
ui_print "- Device platform: $ABI"

##################
# Image Patching
##################
install_magisk_autoboot() {
  cd $SCRIPTSDIR

  # Source the boot patcher
  SOURCEDMODE=true
  ui_print "- Backup current boot image"
  cat $BOOTIMAGE > $BACKUP_DIR/backup_boot.img
  ui_print "- Located at $BACKUP_DIR/backup_boot.img"
  . ./boot_patch.sh "$BOOTIMAGE"
  ui_print "- Flashing new boot image"
  flash_image new-boot.img "$BOOTIMAGE"
  case $? in
    1)
      abort "! Insufficient partition size"
      ;;
    2)
      abort "! $BOOTIMAGE is read only"
      ;;
  esac
  ./magiskboot cleanup
  rm -f new-boot.img
}
install_magisk_autoboot
ui_print "- Done"