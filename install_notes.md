# Notes on how to say: "I use arch btw"

**Disk name for example: /dev/sda**  
This will most probably not be the same name as your disk

Type to get into disk partitioning tool
if it asks for options then select gpt

## Partitioning The Disk
First get into the disk partioning tool "cfdisk":  
`cfdisk`  
If it prompts you with 4 options choose "gpt"   
Once in, delete all partitions so all you see is "free space"

Next make 3 new partitions:  
1. 100M for the boot partition (/dev/sda1)
2. 4G for the swap (/dev/sda2)
3. The rest of the disk for the main disk (/dev/sda3)

## Formatting the disk
Format main disk:  
`mkfs.ext4 /dev/sda3`   

Format boot disk:  
`mkfs.fat -F 32 /dev/sda1`   

Format swap:  
`mkswap /dev/sda2`   

## Mount the disks
Mount main disk:  
`mount /dev/sda3 /mnt`   

Make a dir to mount the boot disk into:  
`mkdir -p /mnt/boot/efi`

Mount the boot disk:
`mount /dev/sda1 /mnt/boot/efi`

Turn the swap on:  
`swapon /dev/sda2`

## Install linux/base/idk and required packages
`pacstrap /mnt base linux linux-firmware sof-firmware base-devel nano grub efibootmgr networkmanager`

## Gen fstab (idk what this is)
`genfstab /mnt > /mnt/etc/fstab`

## Go into system
`arch-chroot /mnt`

## Setup date/time
`ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime`

`hwclock --systohc`

Open this file  and uncomment the line where it says something like "en_NZ.UTF-8"   
`nano /etc/locale.gen` 

## Edit another locale file cause some programs use it
`nano /etc/locale.conf`  
SET `LANG=en.NZ_UTF-8`

## Generate locale
`locale-gen`

## Set keyboard
`nano /etc/vconsole.conf`  
SET `KEYMAP=us`

## Set hostname
`nano /etc/hostname`  
Set the content of the file to the hostname eg fusionsid

## Set root password
`passwd` Then follow the prompts to set root password

## Create a user
`useradd -m -G wheel -s /bin/bash <name>`

## Set user's password:  
`passwd <name>`

## Enable / setup sudo 
`EDITOR=nano visudo`
uncomment the line that looks like `%wheel ALL=(ALL) ALL`

## Enable the network manager
`systemctl enable NetworkManager`

## Install grub on the disk
`grub-install /dev/sda` or `grub-install --target=x86-efi --efi-directory=/boot --bootloader-id=GRUB`

## Make the grub config
`grub-mkconfig -o /boot/grub/grub.cfg`

## And boom we are done
Exit the terminal session  
`exit`

## Unmount all drives  
`umount -a`

## And FINALY...
`reboot`
®
Now as long as I didn't fuck up I can now say "I use arch btw"

(alternatively once you open up the terminal just type `archinstall` and follow all the prompts/do the right settings and it should do that shit for you)
