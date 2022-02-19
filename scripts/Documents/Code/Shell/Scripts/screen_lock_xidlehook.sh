#!/bin/bash

set -x

current_dir="$(dirname "$(readlink -f "$0")")"

pkill xidlehook

#rm "/tmp/xidlehook.socket"

XIDLEHOOK_SOCK=/tmp/xidlehook.socket

xidlehook \
	--not-when-audio \
	--not-when-fullscreen \
	--socket $XIDLEHOOK_SOCK \
	--timer 300 \
	"i3lock -n -i '$1' \
	--screen 1 \
	--clock \
	--time-color=#ff5722 \
	--date-color=#ff5722 \
	--date-size=25 \
	--ind-pos="x+w/2:y+h/3*2.1" \
	--radius=140" "" \
	--timer 15 "xset dpms force off" ""
