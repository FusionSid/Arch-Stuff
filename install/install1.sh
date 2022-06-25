# before running make sure to connect to internet and to have curl or git to get this script
# git clone https://github.com/FusionSid/Arch-Stuff.git make sure to clone into the root dir ( /Arch-Stuff )

# Get disk name
clear
lsblk
read -p "Enter disk name: " disk_name
echo "Starting Install..."
echo "Create Partitions:"
sleep 1

# open cfdisk on disk
cfdisk $disk_name

# get partition names
clear
lsblk
read -p "Enter p1 (boot) name: " diskp1
read -p "Enter p2 (swap) name: " diskp2
read -p "Enter p3 (main) name: " diskp3
clear

# format
mkswap $diskp2 # swap
mkfs.ext4 $diskp3 # boot 
mkfs.fat -F 32 $diskp1 # main disk

# mount
mount $diskp3 /mnt
mkdir -p /mnt/boot/efi
mount $diskp1 /mnt/boot/efi

# turn swap on
swapon $diskp2

# Install linux
pacstrap /mnt linux linux-firmware base base-devel grub efibootmgr networkmanager git neofetch nano vim

# fstab
genfstab /mnt > /mnt/etc/fstab

# copy this folder into mnt
cp -r /Arch-Stuff /mnt/Arch-Stuff

# chroot
arch-chroot /mnt