#!/system/bin/sh
reboot_device() {
    setprop ro.bootmode "normal"
    setprop sys.powerctl "reboot"
    reboot
}
if [ "$(getprop autoboot)" != "1" ]; then
    setprop autoboot 1
    if [ ! -f /sys/class/power_supply/battery/capacity ]; then
        reboot_device
    else
        # Minimum battery capacity to boot
        MIN_CAPACITY=5
        # Maximum number of attempts to check battery capacity
        MAX_ATTEMPTS=10
        c=0
        while [ $c -lt $MAX_ATTEMPTS ]; do
            CAPACITY=$(cat /sys/class/power_supply/battery/capacity)
            case $CAPACITY in
                ''|*[!0-9]*) CAPACITY=100 ;; # Set CAPACITY to 100 if it's not a number
            esac
            # If battery capacity is greater than minimum capacity or reached maximum attempts
            if [ "$CAPACITY" -gt $MIN_CAPACITY ] || [ $c -eq $((MAX_ATTEMPTS-1)) ]; then
                reboot_device
                exit
            fi
            # Wait for battery to charge
            sleep 10
            c=$((c+1))
        done
    fi
fi