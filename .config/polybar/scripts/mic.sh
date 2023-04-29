#!/bin/sh

if pamixer --default-source --get-mute | grep -q true; then
    echo "󰍭"
else
    mic_volume=$(pamixer --default-source --get-volume)
    printf "󰍬 %s%%" "$mic_volume"
fi
