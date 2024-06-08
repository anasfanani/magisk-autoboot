# Magisk-Autoboot-v2.0.0.zip

- Better error handling at shell script.
- Check if battery capacity is exists, if exists then check if has minimum 5% battery each 10 second.
- Max check is 6x / 1 minute, force reboot.
- If files does not exist, reboot directly.
- Use all known rc to trigger autoboot.
- Supported all device ( Tested on Android 13).

## Magisk-Autoboot-simple-v2.0.0.zip
- Only inject all known rc to reboot.
- Verry old device ( Android 4 / 5 / 6 / 7 )

## Group support & Community 
https://t.me/systembinsh/1736

## Warning
Reupload / distributing zip files is not permitted if not include this repository / this release.

# v1.0.1 

## Device Architecture Matching Update
- Removed the `magiskboot` binary and utilized the system-installed `magiskboot` for matching device architecture.
- Added a check for local `magiskboot` in `customize.sh`.
- Replaced `./magiskboot` with `$magiskboot` in `customize.sh` & `scripts/boot_patch.sh` for better compatibility.

# v1.0 

## Initial Release
- Imported necessary scripts from /data/adb/magisk to the scripts directory.
- Modified scripts/boot_patch.sh to enable autoboot.
- The module can now be flashed through either TWRP or the Magisk App.
More information please read from here : https://github.com/anasfanani/magisk-autoboot/releases/latest