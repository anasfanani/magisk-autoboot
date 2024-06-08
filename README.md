[![anasfanani - magisk-autoboot](https://img.shields.io/static/v1?label=anasfanani&message=magisk-autoboot&color=blue&logo=github)](https://github.com/anasfanani/magisk-autoboot "Go to GitHub repo")
[![Github All Releases](https://img.shields.io/github/downloads/anasfanani/magisk-autoboot/total.svg)]()
[![GitHub release](https://img.shields.io/github/release/anasfanani/magisk-autoboot?include_prereleases=&sort=semver&color=blue)](https://github.com/anasfanani/magisk-autoboot/releases/)
[![issues - magisk-autoboot](https://img.shields.io/github/issues/anasfanani/magisk-autoboot)](https://github.com/anasfanani/magisk-autoboot/issues)
[![Telegram Discussion](https://img.shields.io/badge/Discussion-Telegram-blue?style=flat&logo=telegram&link=t.me%2Fsystembinsh%2F1736)](https://t.me/systembinsh/1736)
# Magisk Autoboot

This repository contains a Magisk module designed to enable automatic booting of your Android device when it's connected to a charger or USB.

## Requirements

Before you can use this Magisk module, you need to ensure that:

1. Android device rooted with [Magisk](https://github.com/topjohnwu/Magisk).
2. Basic knowledge for module management.

**Important** :

- **Backup of your `boot.img`** to restore in case of issues.
- This module **not work** on devices where Magisk is installed via the recovery partition. It is designed to work on devices where **Magisk is installed via the boot partition**.

## Installation

1. Download the latest zip file from the [Releases](https://github.com/anasfanani/magisk-autoboot/releases/latest) page.
2. Install the downloaded zip file using Magisk App/TWRP.
3. Power off your phone.

After installation, your Android will boot automatically on cable connected.

## Usage

This module adds `autoboot.init.rc` and `autoboot.sh` to the boot image. The patching process can be viewed in `scripts/boot_patch.sh`. The `scripts` folder is obtained from the installed Magisk on Android in the `/data/adb/magisk` folder. Only some necessary code is imported and then modified for patching `boot.img`. 

In the `autoboot.sh` file, `MIN_CAPACITY=5` is set as the minimum battery percentage threshold before Android boots automatically. If your battery percentage is below 5, the device will wait until it reaches this threshold before booting automatically. If you need to adjust this threshold, change the `MIN_CAPACITY` value in the `autoboot.sh` file and reflash this module.

In case of any errors, your current boot image is backed up under `/data/adb/modules/magisk-autoboot/`. If something happens, you can safely restore them.

## Troubleshooting

If you encounter any issues while using this module, follow these steps:

1. Check if your current boot image is backed up under `/data/adb/modules/magisk-autoboot/`. If it is, try restoring it.

2. Confirm successful installation by checking the presence of the `autoboot.sh` file in the directory outputted by the `magisk --path` command, usually `/debug_ramdisk` or `/sbin`.

If you continue to experience issues, please raise an issue in the repository with a detailed description of the problem, steps to reproduce it, and any error messages you are seeing.

## Manual Patching

If you're an advanced user and want go trough hard way, follow this:

### Preparation

Prepare your boot image by following these steps:

#### Method 1: Using TWRP Terminal

On TWRP, go to Advanced > Terminal and run the following commands:
1. Create base folder for placing boot image files. For example, `mkdir /sdcard/autboot`.
2. Run `dd if=/dev/block/bootdevice/by-name/boot of=/sdcard/autoboot/boot.img` for dump boot.img.

#### Method 2: Using ADB Shell with TWRP Recovery

Boot into TWRP recovery and connect your device to your computer, connect to ADB shell and run the following commands:

```
mkdir /sdcard/autoboot
dd if=/dev/block/bootdevice/by-name/boot of=/sdcard/autoboot/boot.img
```

#### Method 3: Using TWRP Backup

On TWRP, go to Backup and select Boot. Then, swipe to backup.
Your boot image will be backed up to `/sdcard/TWRP/BACKUPS/<device_serial_number>/<name_of_backup>/boot.emmc.win`.
Just copy and place it in a folder `/sdcard/autoboot/` on your device, then rename it to `boot.img`.

### Patching

Create a file named `autoboot.init.rc` in the same folder as `boot.img` with the following contents:

```rc
on charger
 setprop ro.bootmode "normal"
 setprop sys.powerctl "reboot"
```

Execute the following commands:

```sh
/data/adb/magisk/magiskboot unpack boot.img
/data/adb/magisk/magiskboot cpio ramdisk.cpio \
"mkdir 0700 overlay.d" \
"add 0700 overlay.d/autoboot.init.rc autoboot.init.rc"
/data/adb/magisk/magiskboot repack boot.img boot_patched_autoboot.img
/data/adb/magisk/magiskboot cleanup
```

### Flashing

You can flash the patched boot image using the following methods:

#### Method 1: Using TWRP Terminal

On TWRP, go to Advanced > Terminal and run the following commands:

```sh
dd if=/sdcard/autoboot/boot_patched_autoboot.img of=/dev/block/bootdevice/by-name/boot
```

#### Method 2: Using ADB Shell with TWRP Recovery

Boot into TWRP recovery and connect your device to your computer, connect to ADB shell and run the following commands:

```sh
dd if=/sdcard/autoboot/boot_patched_autoboot.img of=/dev/block/bootdevice/by-name/boot
```

#### Method 3: Using TWRP Install

On TWRP, go to Install and select the patched boot image. Then, swipe to flash.

### Power Off

Power off your device and connect it to a charger or USB. Your device should boot automatically.

## Disclaimer

This module is provided "as is" without warranty of any kind, either express or implied, including without limitation any warranties of merchantability, fitness for a particular purpose, and non-infringement. The entire risk as to the quality and performance of the module is with you. Should the module prove defective, you assume the cost of all necessary servicing, repair, or correction.

## Tested Devices

The method has been successfully tested on the following devices:

- Redmi 4X running Android 10 ( With implement minimum battery percentage threshold )
- Samsung J3 (2016) running Android 7.1.2 ( Without implement minimum battery percentage threshold )
- Redmi Note 11 (spesn) Android 13
- More devices

## Notice

OEM Specific device may not work, need to research which rc value should trigger autoboot script !!

## Links

Here are some useful links for further reading:

- [Magisk Details](https://topjohnwu.github.io/Magisk/details.html)
- [Lineage OS Auto Boot on Charge Connected](https://xdaforums.com/t/lineage-os-auto-boot-on-charge-connected.3626364/page-3#post-89178846)
- [How to Change Files in the Boot Image Using Magisk](https://xdaforums.com/t/how-to-change-files-in-the-boot-image-using-magisk.4495645/#post-88571069)

## Credits

- [John Wu & Contributors.](https://github.com/topjohnwu/Magisk) for The Magic Mask for Android
- [bnsmb](https://xdaforums.com/m/bnsmb.8498037/) for the guides at xdaforums.com
- [tparaizo](https://xdaforums.com/m/tparaizo.9457413/) for the guides at xdaforums.com
- [The Chromium OS Authors](https://chromium.googlesource.com/chromiumos/platform/vboot/+/0e5f54d79158f216edeb42bfe9c5cd6d35dc6e0d/) for `futility` binary

## License

This project is licensed under the [MIT License](LICENSE).
