# before running make sure to connect to internet and to have curl or git to get this script

clear
lsblk
read -p "Enter disk name: " disk_name
echo "Starting Install..."
echo "Create Partitions:"
sleep 1

cfdisk $disk_name

# get partition names
clear
lsblk
read -p "Enter p1 (boot) name: " diskp1
read -p "Enter p2 (swap) name: " diskp2
read -p "Enter p3 (main) name: " diskp3

# format
mkswap $diskp2 # swap
mkfs.ext4 $diskp3 # boot 
mkfs.fat -F 32 $diskp1 # main disk

# mount
mount $diskp3 /mnt

mkdir -p /mnt/boot/efi
mount $diskp1 /mnt/boot/efi

swapon $diskp2

# Install linux
pacstrap /mnt base linux linux-firmware sof-firmware base-devel nano grub efibootmgr networkmanager

# fstab
genfstab /mnt > /mnt/etc/fstab

# chroot
arch-chroot /mnt

# ----

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