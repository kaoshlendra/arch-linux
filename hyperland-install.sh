#!/bin/bash

set -e

# Variables
DISK="/dev/sda"  # Change this if your disk is different
HOSTNAME="archlinux"
USERNAME="Deity"
PASSWORD="ubuntu"

# Partition Disk (BIOS/Legacy Mode)
echo "Partitioning Disk..."
parted -s $DISK mklabel msdos
parted -s $DISK mkpart primary ext4 1MiB 100%
mkfs.ext4 ${DISK}1
mount ${DISK}1 /mnt

# Install Base System
pacstrap /mnt base linux linux-firmware vim networkmanager sudo git base-devel

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into System
arch-chroot /mnt /bin/bash <<EOF

# Timezone & Locale
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Hostname
echo "$HOSTNAME" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Root Password
echo "root:$PASSWORD" | chpasswd

# Create User
useradd -mG wheel $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Install Bootloader (Legacy BIOS)
pacman --noconfirm -S grub
grub-install --target=i386-pc $DISK
grub-mkconfig -o /boot/grub/grub.cfg

# Enable Services
systemctl enable NetworkManager

# Install Hyperland & Essentials
pacman --noconfirm -S \
    hyprland hyprpaper hyprlock hypridle \
    waybar rofi mako foot \
    wl-clipboard grim slurp \
    pavucontrol alsa-utils \
    polkit-gnome gvfs thunar \
    xdg-desktop-portal-hyprland

# AUR Helper (yay)
cd /home/$USERNAME
git clone https://aur.archlinux.org/yay.git
chown -R $USERNAME:$USERNAME yay
cd yay
sudo -u $USERNAME makepkg -si --noconfirm

# Optional AUR Packages
sudo -u $USERNAME yay -S --noconfirm wlogout

EOF

# Finished
echo "Installation Complete! Reboot now."