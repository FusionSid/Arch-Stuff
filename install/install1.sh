#!/usr/bin/env bash

## Arch Install Part 1
# This is run on the iso and is used to install arch on the drive

## Requirements:
# Internet connection
# Curl or git installed to get the script

# Get the location of the /Arch-Stuff/ dir
SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
SCRIPT_DIR=$(echo $SCRIPT_DIR | sed 's/install//')
clear

# Get disk name
lsblk
read -p "Enter disk name: " disk_name
echo "Create Partitions:"
sleep 1

# open cfdisk on disk
cfdisk $disk_name
clear

# get partition names
lsblk
read -p "Enter p1 (boot) name: " diskp1
read -p "Enter p2 (swap) name: " diskp2
read -p "Enter p3 (main) name: " diskp3
clear

# format
mkswap $diskp2         # swap
mkfs.ext4 $diskp3      # boot
mkfs.fat -F 32 $diskp1 # main disk

# mount
mount $diskp3 /mnt
mkdir -p /mnt/boot/efi
mount $diskp1 /mnt/boot/efi

# turn swap on
swapon $diskp2

# Install linux
clear
pacstrap /mnt linux linux-firmware base base-devel grub efibootmgr networkmanager git neofetch nano vim
clear

# fstab
genfstab /mnt >/mnt/etc/fstab

# copy this folder into mnt
cp -r $SCRIPT_DIR /mnt/Arch-Stuff

# chroot
arch-chroot /mnt /bin/bash /Arch-Stuff/install/install2.sh
