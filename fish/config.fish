set fish_greeting
set spanish_study_path "/mnt/27AE92097B9FEE4C/spanish_words"
alias sx="startx"
alias gss="cd $spanish_study_path"
alias upd="sudo pacman -Syu"
fish_vi_key_bindings
set -g EDITOR "vim"
if status is-interactive
# Commands to run in interactive sessions can go here
end
