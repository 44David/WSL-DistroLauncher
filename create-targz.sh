#!/bin/bash


# install necessary dependencies and keyrings if not already installed
sudo apt-get -y -q update
sudo apt-get -y -q install curl gnupg cdebootstrap debian-archive-keyring tar

#create target directory
sudo mkdir -p ~/debian-installer
cd ~/debian-installer

# create a bootstrap of ISO

if [ "$1" == "debian" ]
    then 
        sudo cdebootstrap --arch amd64 bookworm --include=vim,git,ssh,man ~/debian-installer/rootfs http://deb.debian.org/debian
fi

# installs necessary packages in directory
sudo chroot ~/debian-installer/rootfs /bin/bash

apt-get update
# apt-get install -y wget git
# # apt-get install -y wget vim,sudo,git,ssh,gnupg,man,curl


apt-get clean
rm -rf /var/lib/apt/lists/*


exit 

# create tar.gz
sudo tar -czf debian-installer.tar.gz -C ~/debian-installer/rootfs .

echo "ISO image successfully bootstrapped"

echo "Copying debian-installer.tar.gz to windows machine..."

# copies the tar.gz onto windows

cd ~/debian-installer
cp debian-installer.tar.gz /mnt/c