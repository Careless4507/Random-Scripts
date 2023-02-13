#!/bin/bash

# Install dependencies for building the additions
if command -v apt-get &>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y wget dkms build-essential linux-headers-$(uname -r)
elif command -v yum &>/dev/null; then
  sudo yum update
  sudo yum install -y wget dkms kernel-devel
elif command -v dnf &>/dev/null; then
  sudo dnf update
  sudo dnf install -y wget dkms kernel-devel
else
  echo "Error: package manager not supported"
  exit 1
fi

# Download the latest version of the additions ISO
latest_version=$(wget -qO- https://download.virtualbox.org/virtualbox/LATEST.TXT)
wget https://download.virtualbox.org/virtualbox/${latest_version}/VBoxGuestAdditions_${latest_version}.iso

# Mount the virtualbox additions iso
sudo mount -o loop VBoxGuestAdditions_${latest_version}.iso /mnt

# Install the additions
sudo /mnt/VBoxLinuxAdditions.run

# Unmount the iso
sudo umount /mnt

# Clean up
sudo rm VBoxGuestAdditions_${latest_version}.iso

# Remove dependencies
if command -v apt-get &>/dev/null; then
  sudo apt-get remove -y wget dkms build-essential linux-headers-$(uname -r)
  sudo apt-get autoremove -y
elif command -v yum &>/dev/null; then
  sudo yum remove -y wget dkms kernel-devel
elif command -v dnf &>/dev/null; then
  sudo dnf remove -y wget dkms kernel-devel
fi
