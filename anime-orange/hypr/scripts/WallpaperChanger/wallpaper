#!/bin/bash

# Get the directory of the script
wallpaper_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
wallpapers_dir="${wallpaper_path}/wallpapers"
files=("${wallpapers_dir}"/*)
waybar_template=~/.config/waybar/waybar-colors.css  # Fixed path typo

# Check if wallpapers directory exists; if not, create it
if [[ ! -d "$wallpapers_dir" ]]; then
    echo "Wallpapers directory not found, creating: $wallpapers_dir"
    mkdir -p "$wallpapers_dir"
fi

# Check if hyprpaper socket exists before proceeding
socket_dir="/run/user/$(id -u)/hypr/"
socket_path=$(find "$socket_dir" -name ".hyprpaper.sock" 2>/dev/null | head -n1)

if [[ ! -S "$socket_path" ]]; then
    echo "Error: hyprpaper socket not found or inaccessible."
    echo "Make sure hyprpaper is running inside your Hyprland session."
    exit 1
fi

# File to keep track of current wallpaper index
index_file="${wallpaper_path}/current_index.txt"

# Function to set wallpaper by index
set_wallpaper_by_index() {
    local idx=$1
    if (( idx < 0 || idx >= ${#files[@]} )); then
        echo "Index out of range"
        exit 1
    fi
    wallpaper_path="${files[$idx]}"
    echo "$idx" > "$index_file"
}

# Function to set wallpaper by filename
set_wallpaper_by_name() {
    local name=$1
    local file_path="${wallpapers_dir}/${name}"
    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path"
        exit 1
    fi
    wallpaper_path="$file_path"
    # Update index file with the index of this wallpaper if found
    for i in "${!files[@]}"; do
        if [[ "${files[$i]}" == "$file_path" ]]; then
            echo "$i" > "$index_file"
            break
        fi
    done
}

# Load current index or default to 0
if [[ -f "$index_file" ]]; then
    current_index=$(<"$index_file")
else
    current_index=0
fi

case $1 in
    set)
        # Set wallpaper by filename
        if [[ -z "$2" ]]; then
            echo "Usage: $0 set <filename>"
            exit 1
        fi
        set_wallpaper_by_name "$2"
        ;;

    index)
        # Set wallpaper by index
        if [[ "$2" =~ ^[0-9]+$ ]]; then
            set_wallpaper_by_index "$2"
        else
            echo "Usage: $0 index <number>"
            exit 1
        fi
        ;;

    random)
        # Pick a random wallpaper
        random_index=$((RANDOM % ${#files[@]}))
        set_wallpaper_by_index "$random_index"
        ;;

    add)
        # Add a new wallpaper file (copy to wallpapers directory)
        if [[ -z "$2" ]]; then
            echo "Usage: $0 add <path-to-image>"
            exit 1
        fi
        if [[ ! -f "$2" ]]; then
            echo "File not found: $2"
            exit 1
        fi
        cp "$2" "$wallpapers_dir/"
        echo "Added wallpaper: $(basename "$2")"
        exit 0  # Exit here to avoid running wallpaper commands below
        ;;
    back)
        # Go back to previous wallpaper (decrement index)
        new_index=$((current_index - 1))
        if (( new_index < 0 )); then
            new_index=$((${#files[@]} - 1))
        fi
        set_wallpaper_by_index "$new_index"
        ;;

    next)
        # Go to next wallpaper (increment index)
        new_index=$((current_index + 1))
        if (( new_index >= ${#files[@]} )); then
            new_index=0
        fi
        set_wallpaper_by_index "$new_index"
        ;;

    *)
        echo "Usage: wallpaper {set <file>|index <num>|random|add <file>|back|next}"
        exit 1
        ;;
esac

socket_dir="/run/user/$(id -u)/hypr/"
socket_path=$(find "$socket_dir" -name ".hyprpaper.sock" 2>/dev/null | head -n1)

if [[ ! -S "$socket_path" ]]; then
    echo "Error: hyprpaper socket not found or inaccessible."
    echo "Make sure hyprpaper is running inside your Hyprland session."
    exit 1
fi

# Preload the wallpaper for faster switching
hyprctl hyprpaper preload "$wallpaper_path"

# Set the wallpaper on all monitors (empty monitor name means all)
hyprctl hyprpaper wallpaper ",$wallpaper_path"

# Unload unused wallpapers to free memory
hyprctl hyprpaper unload unused

# Run your python script to convert colors
python_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python_path="${python_path}/convert_alpha.py"
python "${python_path}" "${waybar_template}"

wallust run "$wallpaper_path"

# Restart waybar to apply changes
pkill waybar
nohup waybar &>/dev/null &


