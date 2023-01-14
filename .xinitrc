#!/usr/bin/env bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
/usr/libexec/polkit-gnome-authentication-agent-1&
nm-applet&
picom --vsync --backend glx&
udiskie -t&
# export $(dbus-launch)
export LS_COLORS="ow=34;21"
setxkbmap -layout us,ar -option grp:win_space_toggle
export PATH="$PATH:/usr/sbin"
numlockx&
exec awesome
