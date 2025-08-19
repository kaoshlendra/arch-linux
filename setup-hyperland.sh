#!/bin/bash
# Script to configure Hyperland environment after minimal Arch install

# 4. Create config directories
mkdir -p ~/.config/hypr ~/.config/rofi ~/.config/waybar ~/.config/mako

# Copy default Hyprland config if not already present
if [ ! -f ~/.config/hypr/hyprland.conf ]; then
    cp /etc/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
fi

# 5. Append custom keybinds & autostart apps
cat <<EOL >> ~/.config/hypr/hyprland.conf

# --- Custom additions ---
exec-once = hyprpaper
exec-once = waybar
exec-once = mako

# Keybinds
bind=SUPER,RETURN,exec,foot          # Terminal
bind=SUPER,D,exec,rofi -show drun    # App Launcher
bind=SUPER,R,exec,hyprctl reload     # Reload config
bind=SUPER,ESCAPE,exit               # Exit Hyprland
EOL

# 6. Create Hyprpaper config with default wallpaper
mkdir -p ~/.config/hypr
if [ ! -f ~/.config/hypr/hyprpaper.conf ]; then
    cat <<WP > ~/.config/hypr/hyprpaper.conf
preload = /usr/share/backgrounds/archlinux/archbtw.jpg
wallpaper = ,/usr/share/backgrounds/archlinux/archbtw.jpg
WP
fi

echo "✅ Hyperland configs created!"
echo "👉 Run 'Hyprland' to start your session."
