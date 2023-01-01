#!/usr/bin/env bash
ffmpeg -f alsa -ac 2 -i default -f x11grab -i $DISPLAY "$(date +%s).mp4"
