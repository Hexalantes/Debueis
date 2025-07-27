# Pardus The Archean Milestone 1

This is the releng configuration, not a compiled ISO.

This project is currently in Beta phase and intended for testing purposes only. Use at your own risk.

**Disclaimer:** The "Pardus" name, logo, and related rights belong to TÜBİTAK. This is NOT an official release of Pardus GNU/Linux from TÜBİTAK or https://pardus.org.tr.
This is a PERSONAL and UNOFFICIAL project, aimed at recreating a Pardus-like system based on Arch Linux for educational and experimental purposes.

Special thanks to the Arch Linux community for providing the archiso tools used in this project.
liveuser password is pardus

# Release Notes
- Additional packages (LibreOffice, VLC Media Player, Okular and Java Runtime Environment 8) are added back.
- Simple shell-based AUR helper and Pacman wrapper XPM (XPM is not a Package Manager) added. (Type "xpm help" or "xpm -h" for help.)
- Added a local repo named "Abyss".
- BIOS/UEFI GRUB issue fixed.
- Firefox removed. Added Chromium instead.
- Logo changed to TÜBİTAK's one.
- There is a new wallpaper.
- liveuser password changed back to pardus.

# Build Tips
  - You should create a local repo for building iso, here is the instructions:
  
    - run "repo-add airootfs/var/lib/pacman/abyss/x86_64/abyss.db.tar.zst airootfs/var/lib/pacman/abyss/x86_64/*.tar.zst" when you are in releng directory
    
      - when you run "git clone https://github.com/hexalantes/pardusthearchean && cd pardusthearchean", pardusthearchean is releng directory, get inside 
      
    - then copy the repo directory to /var/lib/pacman/
    
      - run "cp -r airootfs/var/lib/pacman/abyss /var/lib/pacman/abyss" as root (sudo or doas) when you are in releng directory
      
    - now you can build iso with running "mkarchiso -v ." as root (sudo or doas)
    
      - iso file will be in "out" directory
      
      - you can delete "work" directory after building the iso
      
        - run "rm -rf work" as root (sudo or doas)
        

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
