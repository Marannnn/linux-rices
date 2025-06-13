#!/usr/bin/env python3
import sys
import re

def hex_to_rgba(hex_color, alpha=0.7):
    """Convert hex color (#RRGGBB) to rgba(r, g, b, alpha) string."""
    hex_color = hex_color.lstrip('#')
    if len(hex_color) != 6:
        raise ValueError(f"Invalid hex color: {hex_color}")
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    print(hex_color)
    print(r, g, b, alpha)
    return f"rgba({r}, {g}, {b}, {alpha})"

def process_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    # Regex to find the background color definition line
    # This matches lines like: @define-color background {{background}};
    # or @define-color background #112233;
    pattern = re.compile(r'(@define-color background\s+)(\{\{background\}\}|#[0-9a-fA-F]{6})(;)')

    def replacement(match):
        prefix = match.group(1)
        color = match.group(2)
        suffix = match.group(3)

        # If color is placeholder {{background}}, we can't convert here,
        # so just replace with rgba(0,0,0,0.7) or leave it as is.
        if color == '{{background}}':
            # You can decide what to do here; for now, replace with transparent black
            print("shit has gone wrong")
        else:
            try:
                rgba_color = hex_to_rgba(color, 0.7)
            except ValueError:
                print(f"Warning: Invalid hex color '{color}', skipping replacement.")
                rgba_color = color  # fallback to original

        return f"{prefix}{rgba_color}{suffix}"

    new_content = pattern.sub(replacement, content)

    with open(filepath, 'w') as f:
        f.write(new_content)

    print(f"Processed file '{filepath}' and updated background color with 0.7 opacity.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python convert_alpha.py <path_to_wallust_template>")
        sys.exit(1)

    file_path = sys.argv[1]
    process_file(file_path)

