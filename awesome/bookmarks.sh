#!/usr/bin/env bash
declare -A bookmarks
names=""

for line in $(sed '/^#/d' "$HOME/.bookmarks"); do
    arrBookmarks=(${line/=/ })
    bookmarks["${arrBookmarks[0]}"]="${arrBookmarks[1]}"
    names="$names\n${arrBookmarks[0]}"
done

res=$(echo -en $names | fzf)

for site in $(echo ${bookmarks[$res]} | tr "[-*4]" "\n"); do
    if [[ ! -z $site ]]; then
        xdg-open $site&
    fi
done

