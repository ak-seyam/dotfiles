#!/usr/bin/env bash
read -p "Warning: this script assumes you are using Fedora (with 3rd party repositories) based distro [Press return to continue]"

sudo dnf update -y
sudo dnf install -y curl ansible
sudo ansible-galaxy install gantsign.postman
sudo ansible-galaxy install gantsign.visual-studio-code

sudo ansible-pull -U https://github.com/A-Siam/dotfiles -C fedora --extra-vars="username=$USER"
if [[ $PWD == "*dotfiles" ]]; then
    dconf load /org/gnome/ < ./dconf/gnome.init
fi
chmod +x ./.scripts/vim_bootstrap.sh
