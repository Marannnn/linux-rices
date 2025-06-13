#! /bin/bash
notify-send "Working"

#Directory, Projit jednotlive elementy, ty nastavit jako wallpaper + wallust run wallpaper, timeout
wallpaper_array=(~/Obrázky/wallpapers/*)
array_length="${#wallpaper_array[@]}"
for (( i=0 ; i < array_length; ));do
	echo "$i is ${wallpaper_array[$i]}"
	hyprctl hyprpaper wallpaper , "${wallpaper_array[$i]}"

	sleep 3600	#sec
	if (( $i == ("$array_length" -1)  )); then
		i=0
		continue
	fi

	i=$((i+1))
done
