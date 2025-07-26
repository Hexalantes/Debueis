#!/bin/bash

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

useradd -m liveuser
echo "liveuser:pardus" | chpasswd

echo "liveuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/liveuser
chmod 440 /etc/sudoers.d/liveuser

mkdir -p /home/liveuser/Desktop
cat <<EOF > /home/liveuser/Desktop/calamares.desktop
[Desktop Entry]
Type=Application
Version=Beta
Name=Install Pardus The Archean
GenericName=Pardus The Archean Installer
Keywords=pardus;system;installer;
TryExec=calamares
Exec=pkexec calamares
Comment=Calamares — Pardus The Archean Installer
Icon=pardus-logo
Terminal=false
StartupNotify=true
Categories=Qt;System;
X-AppStream-Ignore=true
EOF

mkdir -p /etc/sddm.conf.d

cat <<EOF > /etc/sddm.conf.d/autologin.conf
[Autologin]
User=liveuser
Session=plasma-x11

[General]
Numlock=on
EOF

systemctl enable sddm
systemctl enable NetworkManager

rm -f /etc/lsb-release
cat <<EOF > /etc/lsb-release
DISTRIB_ID="Pardus The Archean"
DISTRIB_RELEASE="Milestone 1"
DISTRIB_DESCRIPTION="Pardus The Archean Milestone 1"
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

chown root:root /usr/share/xsessions/plasma.desktop
chown -R liveuser:liveuser /home/liveuser/.config
chmod 644 /home/liveuser/.config/autostart/calamares.desktop
chmod 644 /usr/share/xsessions/plasma-x11.desktop

pacman-key --init
pacman-key --populate archlinux
