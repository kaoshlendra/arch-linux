3. Enable Networking
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager


(For Wi-Fi use nmtui to connect easily.)

4. Create Configs
mkdir -p ~/.config/hypr ~/.config/rofi ~/.config/waybar ~/.config/mako
cp /etc/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

5. Edit Hyperland Config

Open config:

nano ~/.config/hypr/hyprland.conf


Add these lines at the bottom (or modify existing):

# Autostart utilities
exec-once = hyprpaper
exec-once = waybar
exec-once = mako

# Keybinds
bind=SUPER,RETURN,exec,foot          # Terminal
bind=SUPER,D,exec,rofi -show drun    # App Launcher
bind=SUPER,R,exec,hyprctl reload     # Reload config
bind=SUPER,ESCAPE,exit               # Exit Hyprland

6. Wallpaper (Hyprpaper)
mkdir -p ~/.config/hypr
nano ~/.config/hypr/hyprpaper.conf


Example:

preload = /usr/share/backgrounds/archlinux/archbtw.jpg
wallpaper = ,/usr/share/backgrounds/archlinux/archbtw.jpg


(Replace with your own wallpaper path if needed.)

7. Start Hyperland

From your TTY (logged in as user):

Hyprland


✅ Now you should have:

Rofi as app launcher (SUPER + D)

Foot as terminal (SUPER + Enter)

Waybar as status bar

Mako for notifications

Hyprpaper for wallpapers
