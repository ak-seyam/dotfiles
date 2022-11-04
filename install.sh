#!/usr/bin/env bash
echo "Warning: this script assumes you are using Debian/Ubuntu based distro"

sudo apt update && sudo apt upgrade -y
sudo apt install curl ansible -y
sudo ansible-galaxy install gantsign.intellij
sudo ansible-galaxy install gantsign.postman
sudo ansible-galaxy install gantsign.postman
sudo ansible-galaxy install darkwizard242.googlechrome
sudo ansible-pull -U https://github.com/A-Siam/dotfiles --extra-vars="username:$USER"
cat "$HOME/dconf.ini" | dconf load /
