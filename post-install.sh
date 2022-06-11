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
    pacman -S gnome gnome-tweaks --noconfirm;
    systemctl enable gdm
elif [ $desktop == 'kde' ]; then 
    pacman -S plasma kde-applications packagekit-qt5 sddm --noconfirm
    systemctl enable sddm
else
    echo 'Not a valid choice skill issue'
fi

# Copy dotfiles
sudo su sid -c "sudo mkdir -p ~/.config"
sudo su sid -c "sudo cp -r /Arch-Stuff/dotfiles/* ~/.config"

# Oh my zsh
sudo su sid -c "bash $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Yay
sudo su sid -c "cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay"

# Kitty font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
mkdir /usr/share/fonts/FiraCode
unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode
rm -rf /Arch-Stuff/fc.zip

# End
echo "Setup complete!\nType `exit` then `reboot` to complete""