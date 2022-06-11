# Copy dotfiles
sudo mkdir -p ~/.config
sudo cp -r /Arch-Stuff/dotfiles/* ~/.config

# Install Yay
cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -rf yay

# Oh my zsh
yay -S oh-my-zsh-git --noconfirm

# Kitty font
sudo wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" -O /Arch-Stuff/fc.zip
sudo mkdir /usr/share/fonts/FiraCode
sudo unzip /Arch-Stuff/fc.zip -d /usr/share/fonts/FiraCode

# zshrc
cp /Arch-Stuff/.zshrc ~/.zshrc

# End
echo "Setup complete!\nType `exit` then `reboot` to complete"