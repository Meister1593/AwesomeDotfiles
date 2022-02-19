#!/bin/bash

#pkill "dowhilerunning.sh"

WindowLabel[0]="blender"
WindowLabel[1]="minecraft"
WindowLabel[2]="r5apex"
WindowLabel[3]="ksp"
WindowLabel[4]="DSPGAME.exe"
WindowLabel[5]="RimWorldLinux"
WindowLabel[6]="RimWorldWin64.e"
WindowLabel[7]="CelestialCommand.x86_64"
WindowLabel[8]="SpaceEngineers.exe"
Windowlabel[9]="Titanfall2.exe"

# Prep mouse scrolling with button
# get name from `xinput`
Mouses[0]='A4tech BT 3.0 Mouse'
Mouses[1]='A4tech A4tech 2.4G Wireless Device Mouse'
Mouses[2]='A4TECH USB Device'
Mouses[3]='Logitech ERGO M575'

echo "[INFO] [CUSTOM] Starting DoWhileRunning script"

for mouse in "${Mouses[@]}"; do
    xinput set-prop pointer:"$mouse" 'libinput Button Scrolling Button' 2 
done

is_scroll_enabled=false

do_this_if_process_is_running() {
# Disable scrolling with middle mouse
for mouse in "${Mouses[@]}"; do
    xinput set-prop pointer:"$mouse" 'libinput Scroll Method Enabled' 0 0 0
done
is_scroll_enabled=false
}

do_this_if_process_is_not_running() {
# Enable scrolling with middle mouse
for mouse in "${Mouses[@]}"; do
    xinput set-prop pointer:"$mouse" 'libinput Scroll Method Enabled' 0 0 1
done
is_scroll_enabled=true
}

get_active_window_name() {
#     echo $(xdotool getactivewindow getwindowname)
#    echo $(xdotool getwindowname $(xdotool getmouselocation --shell | tail -1 | cut -d = -f 2))
	local process_name_unformatted=$(ps -p $(xdotool getwindowpid  $(xdotool getmouselocation --shell | tail -1 | cut -d = -f 2) 2>/dev/null) -o cmd= 2>/dev/null)
	echo	$process_name_unformatted | cut -d ' ' -f1
}

trap do_this_if_process_is_running ERR EXIT
shopt -s nocasematch

while :; do
    for process_name in "${WindowLabel[@]}"; do
        if [[ $(get_active_window_name) == *"$process_name"* ]]; then
            if [ "$is_scroll_enabled" = true ]; then 
                do_this_if_process_is_running 
            fi
            while [[ $(get_active_window_name) == *"$process_name"* ]]; do
                sleep 0.5s ## Sits here while the process is running
            done
        else
            if [ "$is_scroll_enabled" = false ]; then
                do_this_if_process_is_not_running
            fi
        fi
    done
    sleep 2.5s ## How often to delay checking for a process is running
done
