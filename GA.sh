#!/bin/bash
echo -e  '\e[96mCreating temporary folder...\e[0m'
sleep 1
mkdir GA
cd GA
echo -e '\e[96mChecking for latest version...\e[0m'
sleep 1
LATEST_VERSION=$(wget -qO- https://download.virtualbox.org/virtualbox/LATEST.TXT)
echo -e '\e[96mLatest version is '$LATEST_VERSION'\e[0m'
sleep 1
echo -e '\e[96mDownloading Guest Additions...\e[0m'
sleep 1
wget https://download.virtualbox.org/virtualbox/$LATEST_VERSION/VBoxGuestAdditions_$LATEST_VERSION.iso
echo -e '\e[96mDownload Complete!\e[0m'
sleep 1
echo -e '\e[96mExtracting ISO contents...\e[0m'
sleep 1
mkdir "$HOME/vbox" &> /dev/null
isoinfo -i "VBoxGuestAdditions_$LATEST_VERSION.iso" -x "/VBoxLinuxAdditions.run" -o "$HOME/vbox/VBoxLinuxAdditions.run"
if [ $? -ne 0 ]; then
  echo -e '\e[91mFailed to extract ISO contents\e[0m'
  exit 1
else
  echo -e '\e[96mISO contents extracted! Run the install script located at '$HOME/vbox/VBoxLinuxAdditions.run'\e[0m'
  read -p "Do you want to run the install script now? (y/n): " run_install
  if [ "$run_install" == "y" ]; then
    sudo bash "$HOME/vbox/VBoxLinuxAdditions.run"
  fi
fi
