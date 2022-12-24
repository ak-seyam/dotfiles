#!/usr/bin/env bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1&
nm-applet&
picom --vsync --backend glx&
udiskie -t&
export $(dbus-launch)
export LS_COLORS="ow=34;21"
exec awesome
