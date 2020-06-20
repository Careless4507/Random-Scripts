#!/bin/bash
echo -e  '\e[96mCreating temporary folder...\e[0m'
sleep 1
mkdir GA
cd GA
echo -e '\e[96mDownloading Guest Additions...\e[0m'
sleep 1
wget https://download.virtualbox.org/virtualbox/6.1.10/VBoxGuestAdditions_6.1.10.iso
echo -e '\e[96mDownload Complete!\e[0m'
sleep 1
echo -e '\e[96mMounting the ISO\e[0m'
sleep 1
mkdir /mnt/vbox &> /dev/null
mount ./VBoxGuestAdditions_6.1.10.iso /mnt/vbox -o loop &> /dev/null
echo -e '\e[96mISO Mounted! Cd to /mnt/vbox and run the install script!\e[0m'
