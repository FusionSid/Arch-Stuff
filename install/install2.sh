# get disk name for grub install at the end
clear
lsblk
read -p "Enter disk name: " disk_name

# download some pacman things
pacman -Syu && pacman -S ntp zsh wget neofetch tmux unzip wget lolcat iwd tree htop python3.10 bashtop network-manager-applet openssh git xorg xorg-xinit --noconfirm

# locale and time
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
sed -i.backup -e "170 s/^#//" /etc/locale.gen
echo "LANG=en.NZ_UTF-8" > /etc/locale.conf
ntpd -qg
hwclock --systohc
locale-gen

# set keymap and hostname
echo "KEYMAP=us" > /etc/vconsole.conf
echo "fusionsid" > /etc/hostname

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
clear
echo "Uncomment line"
sleep 1
visudo

# Turn on network manager
systemctl enable NetworkManager

# Install grub and create config
grub-install $disk_name
grub-mkconfig -o /boot/grub/grub.cfg

# End
echo "Setup complete!\nType `exit` then `reboot` to complete"