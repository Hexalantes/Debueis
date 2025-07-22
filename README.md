# Pardus The Archean Beta 2
that's the releng, not compiled.

! This project is still in Beta phase and available for testing purposes, use at your own risk !

Pardus name rights belong to TÜBİTAK.
Much thanks to the Arch Linux community for providing archiso.

liveuser password is pardus

# Release Notes
- Asset Update, there's a new background and a new logo.
- pacman-key issue is fixed.
- Calamares welcome image is changed.
- Archiso /etc/motd issue is fixed.
- LibreOffice, VLC Media Player, Okular and Java Runtime Environment 8 are pre-installed now.
- "calamares.desktop" is removed from /usr/share/applications but Calamares binary is not removed.
  
# Known Issues
-Automated Install can not install and configure bootloader on Legacy BIOS/CSM, you should do it manually.
Legacy BIOS/CSM installation instructions are below here.
  1st, delete "- grubcfg" and "- bootloader" from /etc/calamares/settings.conf.
  2nd, install the system normally.
  3rd, mount your hard drive to /mnt (sudo mount /dev/sdX /mnt) (replace /dev/sdX with your drive, e.g. /dev/sda).
  4th, chroot to your hard drive (sudo arch-chroot /mnt).
  5th, run "grub-install /dev/sdX" (replace /dev/sdX with your drive, e.g. /dev/sda).
  6th, run "grub-mkconfig -o /boot/grub/grub.cfg



# License

This project is licensed under the GNU General Public License v3.0 (GPLv3).  
See the LICENSE file for details.

Copyright (C)  Hexalantes

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
