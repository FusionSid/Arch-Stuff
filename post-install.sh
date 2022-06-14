# desktop enviroment
read -p "gnome, kde or xfce? " desktop
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
else
    echo 'Not a valid choice skill issue'
fi

# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r /Arch-Stuff/dotfiles/* ~/.config

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay

# Oh my zsh
yay -S oh-my-zsh-git --noconfirm

# Terminal font
sudo wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
sudo mkdir /usr/share/fonts/FiraCode
sudo unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode

# .zshrc
cp /Arch-Stuff/dotfiles/.zshrc ~/.zshrc

# Install pip
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

echo "Setup complete!"