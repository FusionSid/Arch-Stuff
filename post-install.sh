# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r /Arch-Stuff/dotfiles/* ~/.config

# Oh my zsh
sh $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay

# Kitty font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
mkdir /usr/share/fonts/FiraCode
unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode
rm -rf /Arch-Stuff/fc.zip

# End
echo "Setup complete!\nType `exit` then `reboot` to complete""