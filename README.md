# Pardus The Archean Milestone 1

This is the releng configuration, not a compiled ISO.

This project is currently in Beta phase and intended for testing purposes only. Use at your own risk.

**Disclaimer:** The "Pardus" name, logo, and related rights belong to TÜBİTAK. This is NOT an official release of Pardus GNU/Linux from TÜBİTAK or https://pardus.org.tr.
This is a PERSONAL and UNOFFICIAL project, aimed at recreating a Pardus-like system based on Arch Linux for educational and experimental purposes.

Special thanks to the Arch Linux community for providing the archiso tools used in this project.
liveuser password is zen

# Release Notes
- Additional packages (LibreOffice, VLC Media Player, Okular and Java Runtime Environment 8) are added back.
- Simple shell-based AUR and Pacman helper XPM (XPM is not a Package Manager) added. (Type "xpm help" or "xpm -h" for help.)
- Added a local repo named "Abyss".
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

Copyright (C) Archean Exercitus

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
