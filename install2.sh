# get disk name for grub install at the end
read -p "Enter disk name: " disk_name

# download some pacman things
pacman -Syu && pacman -S ntp zsh wget tmux unzip wget vim firefox kitty neofetch lolcat iwd htop bashtop network-manager-applet git xorg xorg-xinit --noconfirm

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

# Select desktop enviroment
read -p "gnome or kde? " desktop
if [ $desktop == 'gnome' ]; then 
    sudo pacman -S gnome gnome-tweaks;
    sudo systemctl enable gdm
elif [ $desktop == 'kde' ]; then 
    sudo pacman -S plasma kde-applications packagekit-qt5 sddm --noconfirm
    sudo systemctl enable sddm
else
    echo 'Not a valid choice skill issue'
fi