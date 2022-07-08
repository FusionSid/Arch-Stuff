#!/usr/bin/env bash


## Post install script
## This is to be optionally ran after installing arch. It sets up the GUI and other things


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

## Begin
# desktop enviroment/gui
read -p "Would you like to install a desktop enviroment? (y/N) " installdesktop
if [ "$installdesktop" == "y" ] || [ "$installdesktop" == "yes" ]; then
    read -p "gnome, kde, bspwm or xfce? " desktop
    if [ $desktop == 'gnome' ]; then 
        sudo pacman -S gnome gnome-tweaks;
        sudo systemctl enable gdm
    elif [ $desktop == 'kde' ]; then 
        sudo pacman -S plasma konsole packagekit-qt5 sddm --noconfirm
        sudo systemctl enable sddm
    elif [ $desktop == 'xfce' ]; then 
        sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter --noconfirm
        sudo systemctl enable lightdm
    elif [ $desktop == 'bspwm' ]; then 
        sudo pacman -S bspwm sxhkd dmenu polybar picom feh arandr --noconfirm
        sudo chmod +x ~/.config/polybar/launch.sh
    else
        echo 'Not a valid choice skill issue'
    fi
else
    echo "ok"
fi

# Change owner for home dir
cd 
sudo chown -R sid .

# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r $SCRIPT_DIR/config/* ~/.config

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd && rm -rf yay

# Oh my zsh
yay -S oh-my-zsh-git --noconfirm

# Terminal font
sudo wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O $SCRIPT_DIR/fc.zip
sudo mkdir -p /usr/share/fonts/FiraCode
sudo unzip $SCRIPT_DIR/fc.zip -d /usr/share/fonts/FiraCode

# Install pip
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Home dir
cp -r $SCRIPT_DIR/home/. ~/

echo "Setup complete!"
