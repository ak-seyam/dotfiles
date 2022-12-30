#!/usr/bin/env bash

res=$(fzf << EOO
poweroff
reboot
logout
EOO
)

case $res in
    "poweroff")
        poweroff
        ;;
    "reboot")
        reboot
        ;;
    "logout")
        loginctl terminate-user $USER
        ;;
esac
