#!/bin/bash

useradd -m liveuser
echo "liveuser:live" | chpasswd

pacman -U --no-confirm /etc/pardusinstaller/calamares-git-3.3.14.r25.g95aa33f-1-x86_64.pkg.tar.zst

echo "liveuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/liveuser
chmod 440 /etc/sudoers.d/liveuser

mkdir -p /etc/sddm.conf.d
cat <<EOF > /etc/sddm.conf.d/autologin.conf
[Autologin]
User=liveuser
Session=plasma.desktop

[General]
Numlock=on
EOF

systemctl enable sddm
systemctl enable NetworkManager

rm -f /etc/lsb-release
cat <<EOF > /etc/lsb-release
DISTRIB_ID="Pardus The Archean"
DISTRIB_RELEASE="Beta 1"
DISTRIB_DESCRIPTION="Pardus The Archean Beta 1"
EOF

mkdir -p /home/liveuser/.config/autostart
cat <<EOF > /home/liveuser/.config/autostart/calamares.desktop
[Desktop Entry]
Type=Application
Exec=pkexec calamares
Name=Pardus The Archean Installer
Icon=pardus-logo
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

chown -R liveuser:liveuser /home/liveuser/.config
chmod 644 /home/liveuser/.config/autostart/calamares.desktop
