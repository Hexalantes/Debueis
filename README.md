# Debueis Linux

This is the releng configuration, not a compiled ISO.

This project is a rolling release and may not be stable everytime. Use at your own risk.

Special thanks to the Arch Linux authors and community for providing the archiso tools used in this project.
liveuser password is debueis

# Build Tips
  - You should create a local repo for building iso, here is the instructions:
  
    - run "repo-add airootfs/var/lib/pacman/debueis/x86_64/debueis.db.tar.zst airootfs/var/lib/pacman/debueis/x86_64/*.tar.zst" when you are in releng directory
    
      - when you run "git clone https://github.com/hexalantes/debueis && cd debueis", debueis is releng directory, get inside 
      
    - then copy the repo directory to /var/lib/pacman/
    
      - run "cp -r airootfs/var/lib/pacman/debueis /var/lib/pacman/debueis" as root (sudo or doas) when you are in releng directory
      
    - now you can build iso with running "mkarchiso -v ." as root (sudo or doas)
    
      - iso file will be in "out" directory
      
      - you can delete "work" directory after building the iso
      
        - run "rm -rf work" as root (sudo or doas)
        

# License

This project is licensed under the GNU General Public License v3.0 (GPLv3).  
See the LICENSE file for details.

Copyright (C) Hexalantes

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
