picom &
lxsession &
udiskie &
xfce4-power-manager &
systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
export CM_DIR="$HOME/.clipmenu_cache"
export CM_HISTLENGTH="2000"
clipmenud &
gxkb &
exec i3
