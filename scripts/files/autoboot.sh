#!/system/bin/sh

CAPACITY=$(cat /sys/class/power_supply/battery/capacity)
MIN_CAPACITY=5
if [ $CAPACITY -gt $MIN_CAPACITY ]
then
    sleep 1
    setprop ro.bootmode "normal"
    setprop sys.powerctl "reboot"

else
    while [[ $CAPACITY -le $MIN_CAPACITY ]]; do
        sleep 60  
        CAPACITY=$(cat /sys/class/power_supply/battery/capacity)  
        if [ $CAPACITY -gt $MIN_CAPACITY ]
        then
            sleep 1
            setprop ro.bootmode "normal"
            setprop sys.powerctl "reboot"
        fi
    done
fi