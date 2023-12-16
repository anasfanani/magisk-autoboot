[![anasfanani - magisk-autoboot](https://img.shields.io/static/v1?label=anasfanani&message=magisk-autoboot&color=blue&logo=github)](https://github.com/anasfanani/magisk-autoboot "Go to GitHub repo")
[![Github All Releases](https://img.shields.io/github/downloads/anasfanani/magisk-autoboot/total.svg)]()
[![GitHub release](https://img.shields.io/github/release/anasfanani/magisk-autoboot?include_prereleases=&sort=semver&color=blue)](https://github.com/anasfanani/magisk-autoboot/releases/)
[![issues - magisk-autoboot](https://img.shields.io/github/issues/anasfanani/magisk-autoboot)](https://github.com/anasfanani/magisk-autoboot/issues)
# Magisk Autoboot

This repository contains a Magisk module designed to enable automatic booting of your Android device when it's connected to a charger or USB.

## Requirements

Before you can use this Magisk module, you need to ensure that:

1. Android device rooted with [Magisk](https://github.com/topjohnwu/Magisk).
2. Basic command line knowledge for module management.
3. Backup of your `boot.img` to restore in case of issues.

## Installation

1. Download the latest zip file from the [Releases](https://github.com/anasfanani/magisk-autoboot/releases/latest) page.
2. Install the downloaded zip file using Magisk App/TWRP.
3. Power off your phone.

After installation, your Android will boot automatically on cable connected.

## Usage

This module adds `autoboot.init.rc` and `autoboot.sh` to the boot image. The patching process can be viewed in `scripts/boot_patch.sh`. The `scripts` folder is obtained from the installed Magisk on Android in the `/data/adb/magisk` folder. Only some necessary code is imported and then modified for patching `boot.img`. 

In the `autoboot.sh` file, `MIN_CAPACITY=5` is set as the minimum battery percentage threshold before Android boots automatically. If your battery percentage is below 5, the device will wait until it reaches this threshold before booting automatically. If you need to adjust this threshold, change the `MIN_CAPACITY` value in the `autoboot.sh` file and reflash this module.

In case of any errors, your current boot image is backed up under `/data/adb/modules/magisk-autoboot/AutoBoot-Backup`. If something happens, you can safely restore them.

## Troubleshooting

If you encounter any issues while using this module, follow these steps:

1. Check if your current boot image is backed up under `/data/adb/modules/magisk-autoboot/AutoBoot-Backup`. If it is, try restoring it.

2. Confirm successful installation by checking the presence of the `autoboot.sh` file in the directory outputted by the `magisk --path` command, usually `/debug_ramdisk` or `/sbin`.

If you continue to experience issues, please raise an issue in the repository with a detailed description of the problem, steps to reproduce it, and any error messages you are seeing.

## Disclaimer

This module is provided "as is" without warranty of any kind, either express or implied, including without limitation any warranties of merchantability, fitness for a particular purpose, and non-infringement. The entire risk as to the quality and performance of the module is with you. Should the module prove defective, you assume the cost of all necessary servicing, repair, or correction.

## Tested Devices

The patch has been successfully tested on the following devices:

- Redmi 4X running Android 10
- Samsung J3 (2016) running Android 7.1.2
- Redmi Note 11 (spesn) Android 13

## Links

Here are some useful links for further reading:

- [Magisk Details](https://topjohnwu.github.io/Magisk/details.html)
- [Lineage OS Auto Boot on Charge Connected](https://xdaforums.com/t/lineage-os-auto-boot-on-charge-connected.3626364/page-3#post-89178846)
- [How to Change Files in the Boot Image Using Magisk](https://xdaforums.com/t/how-to-change-files-in-the-boot-image-using-magisk.4495645/#post-88571069)

## Credits

- [John Wu & Contributors.](https://github.com/topjohnwu/Magisk) for The Magic Mask for Android
- [bnsmb](https://xdaforums.com/m/bnsmb.8498037/) for the guides at xdaforums.com
- [tparaizo](https://xdaforums.com/m/tparaizo.9457413/) for the guides at xdaforums.com

## License

This project is licensed under the [MIT License](LICENSE).
