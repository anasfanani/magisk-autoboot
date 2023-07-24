##  [English](README.md) | [Bahasa Indonesia](README-id.md)

### AutoBoot Patch for Android Devices

This repository contains scripts and instructions to apply an AutoBoot patch to the `boot.img` of Android devices using Magisk. The AutoBoot patch enables the device to automatically boot to the home screen after a USB connection is detected.

### Prerequisites

Before running the patch script, make sure you have the following:

- A rooted Android device with Magisk installed.

### Step-by-Step Guide: AutoPatch

1. Download the latest release from this repository.

2. Extract the contents of the release to your desired path, for example: `/sdcard/autoboot/`.

3. Reboot your device into recovery mode.

4. Open a terminal or use ADB shell to run the following command:

```bash
sh patch.sh auto
```

5. The patching process will start, and your device will automatically apply the AutoBoot patch.

6. After the patching is complete, check if the patch is working:

   - Unplug the phone's USB cable.
   - Power off the phone.
   - Plug in the USB cable again.
   - The phone should boot, then shut down itself, and finally, auto-boot to the home screen. If this happens, the patch is working successfully.

### Step-by-Step Guide: Manual Patch

1. Locate the `boot.img` file on your device.

2. Dump the `boot.img` to a directory on your device.

3. Patch the `boot.img` using MagiskBoot:

```bash
/data/adb/magisk/magiskboot unpack boot.img
/data/adb/magisk/magiskboot cpio ramdisk.cpio \
"mkdir 0700 overlay.d" \
"add 0700 overlay.d/init.custom.rc files/init.custom.rc" \
"mkdir 0700 overlay.d/sbin" \
"add 0700 overlay.d/sbin/custom.sh files/init.custom.sh"
/data/adb/magisk/magiskboot repack boot.img boot_patched_autoboot.img
/data/adb/magisk/magiskboot cleanup
```

4. Flash the patched `boot.img` back to the boot partition. You can use the following command (adjust the paths accordingly):

```bash
dd if=/sdcard/autoboot/boot_patched_autoboot.img of=/dev/block/bootdevice/by-name/boot
```

### Important Notes

- The patching process modifies the `boot.img`, which is a critical component of the Android system. Be cautious while applying patches and ensure you have proper backups in case anything goes wrong.
- The provided `init.custom.sh` contains a proof-of-concept line that triggers a reboot. Avoid using this line in a production environment.

### Disclaimer

Use the provided scripts and patches at your own risk. The repository owner and contributors are not responsible for any damage or issues that may occur as a result of using these scripts.

### Tested Devices

The patch has been successfully tested on the following devices:

- Redmi 4X running Android 10
- Samsung J3 (2016) running Android 7.1.2

### License

This project is licensed under the [MIT License](LICENSE).

### Contribution Guidelines

Contributions to this repository are welcome. If you have any improvements, bug fixes, or new features to suggest, feel free to create a pull request.

### Contact Information

For questions or inquiries, you can reach out to the repository owner [here](mailto:lexaveykov@gmail.com).

---