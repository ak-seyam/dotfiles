#!/usr/bin/env bash
declare -A bookmarks
names=""

for line in $(sed '/^#/d' "$HOME/.bookmarks"); do
    arrBookmarks=(${line/=/ })
    bookmarks["${arrBookmarks[0]}"]="${arrBookmarks[1]}"
    names="$names\n${arrBookmarks[0]}"
done

res=$(echo -en $names | sed '1d' | fzf --reverse --prompt="type bookmark tag: ")

if [[ ! -z $res ]]; then
    for site in $(echo ${bookmarks[$res]} | sed "s/<>/\n/g"); do
        if [[ ! -z $site ]]; then
            xdg-open $site&
        fi
    done
fi
