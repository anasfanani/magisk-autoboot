#!/sbin/sh
function show_help() {
    echo "Usage: patch.sh [option]"
    echo "Options:"
    echo "  help             Display this help menu."
    echo "  patch            Apply patches to the boot.img."
    echo "  dump             Dump the boot.img."
    echo "  flash            Flash the modified boot.img."
    echo "  auto             Perform all patching operations automatically."
}

function apply_patch() {
    # Check if /data/adb/magisk/magiskboot exists
    if [ ! -x "/data/adb/magisk/magiskboot" ]; then
        echo "Error: /data/adb/magisk/magiskboot not found or not executable."
        exit 1
    fi

    # Check if boot.img exists
    if [ ! -f "boot.img" ]; then
        echo "Error: boot.img not found."
        exit 1
    fi

    echo "Applying patches to boot.img..."
    /data/adb/magisk/magiskboot unpack boot.img
    /data/adb/magisk/magiskboot cpio ramdisk.cpio \
    "mkdir 0700 overlay.d" \
    "add 0700 overlay.d/init.custom.rc files/init.custom.rc" \
    "mkdir 0700 overlay.d/sbin" \
    "add 0700 overlay.d/sbin/custom.sh files/init.custom.sh"
    /data/adb/magisk/magiskboot repack boot.img boot_patched_autoboot.img
    /data/adb/magisk/magiskboot cleanup
    # Add your patching logic here
}



function dump_boot() {
    echo "Dumping contents from boot.img..."
    # Dump boot partition to boot.img
    dump=$(dd if=/dev/block/bootdevice/by-name/boot of=$(pwd)/boot.img 2>&1)

    # Check if the dump process failed
    if [ $? -ne 0 ]; then
        echo "Error: Failed to dump boot partition."
        exit 1
    fi

    echo "Boot partition successfully dumped to boot.img."

    # Add your Dumping logic here
}

function flash_image() {
    echo "Flashing the modified boot.img..."
    
    # Check if the partition /dev/block/bootdevice/by-name/boot exists
    if [ ! -e "/dev/block/bootdevice/by-name/boot" ]; then
        echo "Error: Partition /dev/block/bootdevice/by-name/boot does not exist."
        exit 1
    fi

    # Check if the file $(pwd)/boot_patched_autoboot.img exists
    if [ ! -f "$(pwd)/boot_patched_autoboot.img" ]; then
        echo "Error: File $(pwd)/boot_patched_autoboot.img does not exist."
        exit 1
    fi

    # If both the partition and file exist, flash the image using dd
    dd if=$(pwd)/boot_patched_autoboot.img of=/dev/block/bootdevice/by-name/boot
    echo "Flashing process completed."
}


function auto_patch() {
    # Run dump_boot and check its exit status
    dump_boot
    if [ $? -ne 0 ]; then
        echo "Error: Failed to dump boot partition."
        exit 1
    fi

    # Run apply_patch and check its exit status
    apply_patch
    if [ $? -ne 0 ]; then
        echo "Error: Failed to apply patches to boot.img."
        exit 1
    fi

    # Run flash_image and check its exit status
    flash_image
    if [ $? -ne 0 ]; then
        echo "Error: Failed to flash the modified boot.img."
        exit 1
    fi

    # If all functions succeeded, print success message
    echo "Auto patching process completed successfully."
}


# if [ $# -eq 0 ]; then
#     echo "Error: No option provided. Use 'patch.sh help' for usage information."
#     exit 1
# fi

case "$1" in
    help)
        show_help
        ;;
    patch)
        apply_patch
        ;;
    dump)
        dump_boot
        ;;
    flash)
        flash_image
        ;;
    auto)
        auto_patch
        ;;
    *)
        show_help
        exit 1
        ;;
esac





