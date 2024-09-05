#!/bin/env bash

folder=~/Pictures/wallpapers/

randompick() {
find "$folder" -type f \
	| while read -r img; do
		echo "$((RANDOM % 1000)):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		swww img --transition-type grow --transition-pos 0.5,0.5 --transition-duration 0.75 --transition-fps 60 "$img"
		wal -i "$img" -n
		killall -SIGUSR2 waybar
		pywal-discord -p ~/.config/vesktop/themes/
		pywal-spicetify text
		exit 1
	done
	exit 1
}

pick() {
location="$(ls "$folder" | sort | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary)"

if [[ -d $folder/$location ]]; then
    wall_temp="$location"
elif [[ -f $folder/$location ]]; then
    swww img --transition-type grow --transition-pos 0.5,0.5 --transition-duration 0.75 --transition-fps 60 "$folder"/"$wall_temp"/"$location"
    wal -i "$folder"/"$wall_temp"/"$location" -n
    killall -SIGUSR2 waybar
    pywal-discord -p ~/.config/vesktop/themes/
    pywal-spicetify text
else
    exit 1
fi
exit 1
}

while getopts "rp" opt; do
    case ${opt} in
        r )
	    randompick
            ;;   
        p )
	    pick
            ;;
    esac
done

shift $((OPTIND -1))
