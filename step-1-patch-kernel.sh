#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
set -x

# check we're root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev git
kernel_version=$(uname -r | cut -d'-' -f1,1)
apt-get install linux-source-${kernel_version}

echo "Extracting kernel source"
cd /usr/src
tar -xaf linux-source-${kernel_version}.tar.bz2

echo "Patching"
cd linux-source-${kernel_version}/sound/pci/hda
sed -i '/SND_PCI_QUIRK(0x1043, 0x12af, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2)/a SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", ALC245_FIXUP_CS35L41_SPI_2),' patch_realtek.c
cd /usr/src/linux-source-${kernel_version}

echo "Configuring"

# use current kernel config as base
cp /boot/config-$(uname -r) .config
sed -i 's/^CONFIG_LOCALVERSION=".*"/CONFIG_LOCALVERSION="-asus-speakers-patch"/' .config

echo "Compiling..."
make -j$(nproc)

echo "Installing..."
make modules_install
make install


# update grub and reboot
update-grub
reboot

