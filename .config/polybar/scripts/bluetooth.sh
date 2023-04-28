#!/bin/sh

if systemctl is-active "bluetooth.service" | grep -q inactive; then
    echo "󰂲"
else
    paired_devices=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
    connected_devices=0

    for device in $paired_devices; do
        device_info=$(bluetoothctl info "$device")

        if echo "$device_info" | grep -q "Connected: yes"; then
            device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

            if [ $connected_devices -gt 0 ]; then
                printf ", %s" "$device_alias"
            else
                printf "󰂱 %s" "$device_alias"
            fi

            connected_devices=$((connected_devices + 1))
        fi
    done

    if [ $connected_devices == 0 ]; then
        echo "󰂯"
    fi

    printf '\n'
fi
