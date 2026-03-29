#!/usr/bin/env bash

# display names
POWEROFF_DSP="Power off"
LOCK_DSP="Lock"
REBOOT_DSP="Reboot \\ Restart"

INPUT="$(echo -e "$LOCK_DSP\n$POWEROFF_DSP\n$REBOOT_DSP" | dmenu -i)"

echo $INPUT

case $INPUT in
    "$LOCK_DSP")
        i3lock --show-keyboard-layout
    ;;
    "$POWEROFF_DSP")
        poweroff
    ;;
    "$REBOOT_DSP")
        reboot
    ;;
    "")
        
    ;;
    *)
        notify-send -u critical "Unsupported power control"
        exit 1
    ;;
esac
