# Pardus The Archean Milestone 1
that's the releng, not compiled.

! This project is still in Beta phase and available for testing purposes, use at your own risk !

**Not:** "Pardus" name and logos and their rights are owned by TÜBİTAK. That is NOT an official release of Pardus GNU/Linux from TÜBİTAK and https://pardus.org.tr, that is a PERSONAL PROJECT for building Pardus GNU/Linux based on Arch Linux.

Also much thanks to the Arch Linux community for providing archiso.

liveuser password is zen

# Release Notes
- Additional packages (LibreOffice, VLC Media Player, Okular and Java Runtime Environment 8) are removed.
- Multilib repository added to pacman.
- Some xorg packages  are pre-installed now.
- "Plasma (X11)" added to SDDM sessions.
- New desktop wallpaper.
- Kernel swapped from "linux" to "linux-zen".
- liveuser password changed from "pardus" to "zen".
- In Calamares, "Autologin" and "Require a Strong Password" options are removed from user configuration page.
  
# Known Issues
Automated Install can not install and configure bootloader on Legacy BIOS/CSM, you should do it manually.
Legacy BIOS/CSM installation instructions are below here.
  - delete "- grubcfg" and "- bootloader" from /etc/calamares/settings.conf.
  - install the system normally.
  - mount your hard drive to /mnt (sudo mount /dev/sdX /mnt) (replace /dev/sdX with your drive, e.g. /dev/sda).
  - chroot to your hard drive (sudo arch-chroot /mnt).
  - run "grub-install /dev/sdX" (replace /dev/sdX with your drive, e.g. /dev/sda).
  - run "grub-mkconfig -o /boot/grub/grub.cfg

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
