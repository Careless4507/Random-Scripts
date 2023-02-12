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
echo -e '\e[96mMounting the ISO\e[0m'
sleep 1
mkdir "$HOME/vbox" &> /dev/null
mount "./VBoxGuestAdditions_$LATEST_VERSION.iso" "$HOME/vbox" -o loop &> /dev/null
if [ $? -ne 0 ]; then
  echo -e '\e[91mFailed to mount ISO\e[0m'
  exit 1
else
  echo -e '\e[96mISO Mounted! Cd to '$HOME/vbox' and run the install script!\e[0m'
  read -p "Do you want to run the install script now? (y/n): " run_install
  if [ "$run_install" == "y" ]; then
    cd "$HOME/vbox"
    sudo bash ./VBoxLinuxAdditions.run
  fi
fi
