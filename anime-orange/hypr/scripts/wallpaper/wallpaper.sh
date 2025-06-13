#! /bin/bash

wallpaper_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
files=("${wallpaper_path}"/*)

case $1 in
	set)
		echo "set"
		file="$2"
		wallpaper_path+="/wallpapers/${file}"
	;;

	index)
		echo "index"

		if [[ "$1" == "index" && "$2" =~ ^[0-9]+$ ]]; then
			file=$"{files[$(("$2"))]}"
			wallpaper_path="wallpapers/${file}"
		fi
	;;

	random)
		echo "random"
		random_index="$RANDOM % ${#files[@]}"
		file=$"{files[$(("${random_index}"))]}"
		wallpaper_path="wallpapers/${file}"
	;;

	add)
		echo "add"
	;;

	back)
		echo "back"
	;;
esac

hyprctl hyprpaper preload $wallpaper_path
hyprctl hyprpaper wallpaper , $wallpaper_path
wallust run $wallpaper_path
pkill waybar
nohup waybar
