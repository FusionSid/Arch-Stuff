# desktop enviroment/gui
read -p "Would you like to install a desktop enviroment? (y/N) " installdesktop
if [ "$installdesktop" == "y" ] || [ "$installdesktop" == "yes" ]; then
    read -p "gnome, kde, bspwm or xfce? " desktop
    if [ $desktop == 'gnome' ]; then 
        sudo pacman -S gnome gnome-tweaks firefox kitty;
        sudo systemctl enable gdm
    elif [ $desktop == 'kde' ]; then 
        sudo pacman -S plasma konsole packagekit-qt5 sddm firefox kitty --noconfirm
        sudo systemctl enable sddm
    elif [ $desktop == 'xfce' ]; then 
        sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter firefox kitty --noconfirm
        sudo systemctl enable lightdm
        sudo chown -R sid .
    elif [ $desktop == 'bspwm' ]; then 
        sudo pacman -S bspwm sxhkd dmenu picom feh --noconfirm
    else
        echo 'Not a valid choice skill issue'
    fi
else
    echo "ok"
fi

# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r /Arch-Stuff/config/* ~/.config

# Home dir
cp -r /Arch-Stuff/home/* ~/

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay

# Oh my zsh
yay -S oh-my-zsh-git --noconfirm

# Terminal font
sudo wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
sudo mkdir -p /usr/share/fonts/FiraCode
sudo unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode

# Install pip
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

echo "Setup complete!"