#!/usr/bin/env bash

## Install Part 2
# This is run after arch-chroot. This script is to finish the setup for arch and install some packages

# download some useful packages
pacman -Syu && pacman -S \
    ntp zsh neofetch tmux unzip wget \
    iwd tree htop python3 network-manager-applet \
    openssh git xorg xorg-xinit sudo pulseaudio --noconfirm

# locale and time
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
sed -i.backup -e "170 s/^#//" /etc/locale.gen
echo "LANG=en.NZ_UTF-8" >/etc/locale.conf
ntpd -qg # set time correctly just in case
hwclock --systohc
locale-gen

# set keymap and hostname
echo "KEYMAP=us" >/etc/vconsole.conf
echo "fusionsid" >/etc/hostname

# Root password
clear
echo "Set root password:"
passwd

# Create user named "sid" and set password
clear
useradd -m -G wheel -s /bin/zsh sid
echo "Set password for user:"
passwd sid

# Visudo
visudo
clear

# Turn on network manager
systemctl enable NetworkManager

# get disk name for grub install
clear
lsblk
read -p "Enter disk name: " disk_name

# Install grub and create config
grub-install $disk_name
grub-mkconfig -o /boot/grub/grub.cfg

# End
echo "Setup complete!\nYou may now exit and then reboot\nAlso if you want, you can run the post install script"
