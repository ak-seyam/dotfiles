#!/usr/bin/env bash

# workflows
LANGUAGE_STUDY="language study"
JVM_PROGRAMMING="JVM programming"

WORKFLOW=$(echo -e "$LANGUAGE_STUDY\n$JVM_PROGRAMMING" | dmenu -i -p "Select your workflow")

function close_all() {
    local MAX_RETRIES=10

    i3-msg "[class=\".*\"] kill"

    COUNT=0
    while [ "$(i3-msg -t get_tree | jq '.. | select(.window? != null) | .id' | wc -l)" -gt 1 ] && [ $COUNT -lt $MAX_RETRIES ]; do
        sleep 1
        ((COUNT++))
    done
    if [ $COUNT -eq $MAX_RETRIES ]; then
        notify-send "Window close timeout stopping workflow start"
        exit 1
    fi
}

function language_study() {
    local ANKI_WORKSPACE="1"
    local BROWSER_WORKSPACE="2"
    local GRAMMER_STUDY="https://studyspanish.com/grammar"
    local AI="https://gemini.google.com/app"
    local VOICE_GENERATION="https://elevenlabs.io/app/speech-synthesis/text-to-speech"
    close_all
    i3-msg "workspace $ANKI_WORKSPACE; exec anki;"
    # sleep as anki take sometime to load + sync
    sleep 1
    i3-msg "workspace $BROWSER_WORKSPACE; exec google-chrome-stable $GRAMMER_STUDY $AI $VOICE_GENERATION"    
}

function jvm_programming() {
    local TERMINAL_WORKSPACE="1"
    local BROWSER_WORKSPACE="2"
    local AI="https://gemini.google.com/app"
    local INTELLIJ_IDEA_BIN="/home/a/.local/share/JetBrains/Toolbox/apps/intellij-idea/bin/idea"
    # send safe kill to all open windows
    close_all
    i3-msg "workspace $TERMINAL_WORKSPACE; exec xfce4-terminal;"
    sleep 0.25
    i3-msg "workspace $BROWSER_WORKSPACE; layout tabbed; exec google-chrome-stable $AI; exec $INTELLIJ_IDEA_BIN"    
}

case $WORKFLOW in
    $LANGUAGE_STUDY)
        language_study
    ;;
    $JVM_PROGRAMMING)
        jvm_programming
    ;;
    *)
        notify-send -u critical "Unsupported workflow type"
        exit 1
    ;;
esac


