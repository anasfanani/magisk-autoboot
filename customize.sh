##############
# Preparation
##############

# Default permissions

SCRIPTSDIR=$MODPATH/scripts
BACKUP_DIR="$MODPATH/AutoBoot-Backup"
mkdir -p "$BACKUP_DIR"
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
  cat $BOOTIMAGE > $BACKUP_DIR/backup_boot.img
  ui_print "- Located at $BACKUP_DIR/backup_boot.img"
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
ui_print "- Success"
ui_print "*******************"
ui_print "    Notice:        "
ui_print "*******************"
ui_print "- Please power off your device and see if booting automatically."
ui_print "- If not, please open issue on my repository."
ui_print "- If something error happen, stay calm."
ui_print "- You can restore your boot image by flashing original boot image."
ui_print "- Located at /data/adb/magisk/modules/AutoBoot-Backup/backup_boot.img"
ui_print "- For uninstallation, please restore original boot image."
ui_print "- Or you can use Magisk Manager to uninstall this module."
ui_print "- After uninstallation, please reboot your device."
ui_print "- Thank you for using my module."
ui_print "- Have a nice day."