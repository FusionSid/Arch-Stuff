# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r /Arch-Stuff/dotfiles/* ~/.config

# Oh my zsh
bash $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay

# Kitty font
sudo wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
sudo mkdir /usr/share/fonts/FiraCode
sudo unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode

# Delete folder
sudo rm -rf /Arch-Stuff

# End
echo "Setup complete!\nType `exit` then `reboot` to complete""