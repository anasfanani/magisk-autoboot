##############
# Preparation
##############

# Default permissions

SCRIPTSDIR=$MODPATH/scripts
set_perm_recursive $SCRIPTSDIR 0 2000 0644 0755

# setup_flashable
ui_print "- Magisk Autoboot Installer"
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
  cat $BOOTIMAGE > $MODPATH/backup_boot.img
  ui_print "- Save 'backup_boot.img' at module directory"
  if [ -f $MAGISKBIN/magiskboot ]; then
    magiskboot=$MAGISKBIN/magiskboot
  else
    abort "! Cannot find magiskboot in [$MAGISKBIN]"
  fi
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
  $magiskboot cleanup
  rm -f new-boot.img
}
install_magisk_autoboot
rm -rf $SCRIPTSDIR
ui_print "- Success"
ui_print "*******************"
ui_print "    Notice:        "
ui_print "*******************"
ui_print "- Power off."
ui_print "- Connect charger."
ui_print "- Restore boot.img / Uninstall this module to remove autoboot."