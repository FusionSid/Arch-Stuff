pacman -Syu
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
sed -i.backup -e "170 s/^#//" /etc/locale.gen
echo "LANG=en.NZ_UTF-8" >> /etc/locale.conf
paman -S ntp zsh wget tmux wget vim neofetch lolcat
ntpd -qg
hwclock --systohc
locale-gen
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "fusionsid" >> /etc/hostname

clear
echo "Set root password:"
passwd

clear
useradd -m -G wheel -s /bin/zsh sid
echo "Set password for user:"
passwd sid

visudo

systemctl enable NetworkManager

grub-install $disk_name
grub-mkconfig -o /boot/grub/grub.cfg

# i commented this cause theres legit nothing in those files/folders yet
# mkdir -p ~/.config
# cp -r dotfiles/* ~/.config
# cp .zshrc ~/.zshrc

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd
rm -rf yay

while true; do
    read -p "gnome or kde?" desktop # idk how to use any other desktops lol
    if [ $desktop == 'gnome' ]; then 
        pacman -S xorg gnome gnome-tweaks;
        systemctl enable gdm; 
        break;
    if [ $desktop == 'kde' ]; then 
        pacman -S xorg plasma konsole packagekit-qt5 sddm; 
        systemctl enable sddm; 
        break;
    if [ $desktop == 'none' ]; then 
        break;
    else
        echo 'Not a valid choice'
    fi
done

exit
umount -a
reboot