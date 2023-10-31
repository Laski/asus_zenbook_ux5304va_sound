#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
set -x

# check we're root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt install acpica-tools
iasl -tc ssdt-csc3551.dsl
cp -f ssdt-csc3551.aml /boot
cp -f 01_acpi /etc/grub.d
chmod +x /etc/grub.d/01_acpi
update-grub
reboot
