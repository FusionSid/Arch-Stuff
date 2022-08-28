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
        sudo pacman -S gnome gnome-tweaks
        sudo systemctl enable gdm
    elif [ $desktop == 'kde' ]; then
        sudo pacman -S plasma konsole packagekit-qt5 sddm --noconfirm
        sudo systemctl enable sddm
    elif [ $desktop == 'xfce' ]; then
        sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter --noconfirm
        sudo systemctl enable lightdm
    elif [ $desktop == 'bspwm' ]; then
        sudo pacman -S bspwm sxhkd dmenu polybar picom feh arandr --noconfirm
    else
        echo 'Not a valid choice skill issue'
    fi
else
    echo "ok"
fi


# Copy dotfiles
sudo cp -r $SCRIPT_DIR/config/* ~/.config

# Install Yay

# Terminal font

# Install pip

# Home dir
cp -r $SCRIPT_DIR/home/. ~/

# Give polybar launch script perms
sudo chmod +x ~/.config/polybar/launch.sh

# Useful Yay packages
yay -S vim-plug nvim-packer-git firefox kitty lolcat bashtop \
    hollywood cmatrix neovim mpv gcc starship exa bat \
    zsh-autosuggestions zsh-completions pfetch --noconfirm
clear

# Install vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugInstall" +qa

# Zsh autosuggestions
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Change owner for home dir
cd
sudo chown -R sid .

echo "Setup complete!"
