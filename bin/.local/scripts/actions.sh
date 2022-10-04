#!/usr/bin/env bash

actions="Lock Suspend Exit_sway Reboot Shutdown"
input=`echo $actions | tr ' ' '\n' | tr '_' ' '`
output=`printf "$input" | wofi -d -G -H 180 -W 200 -p Action -i`

case $output in
    "Lock")
        swaylock
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Exit sway")
        swaymsg exit
        ;;
    "Reboot")
        systemctl -i reboot
        ;;
    "Shutdown")
        systemctl -i poweroff
        ;;
esac
