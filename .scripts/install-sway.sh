#!/bin/zsh

#
#	Sway Install Script
#

# Core Sway
sudo pacman -Sy sway swaylock swayidle swaybg xorg-xwayland

# Display Manager
sudo pacman -Sy lemurs

# Status Bar
sudo pacman -Sy waybar

# Utilities
sudo pacman -Sy foot thunar mako rofi networkmanager network-manager-applet psensor

# Bluetooth
sudo pacman -Sy blueman

# Audio
sudo pacman -Sy pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol

# Enable Services
sudo systemctl enable --now seatd.service
sudo systemctl enable lemurs

# Add to seat group
#sudo usermod -aG seat mac
