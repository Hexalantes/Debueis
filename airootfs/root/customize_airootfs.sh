#!/bin/bash

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

useradd -m liveuser
echo "liveuser:debueis" | chpasswd

echo "liveuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/liveuser
chmod 440 /etc/sudoers.d/liveuser

mkdir -p /home/liveuser/Desktop
cat <<EOF > /home/liveuser/Desktop/calamares.desktop
[Desktop Entry]
Type=Application
Version=rolling
Name=Install Debueis Linux
GenericName=Debueis Linux Installer
Keywords=debueis;system;installer;
TryExec=calamares
Exec=pkexec calamares
Comment=Calamares — Debueis Linux Installer
Icon=debueis-logo
Terminal=false
StartupNotify=true
Categories=Qt;System;
X-AppStream-Ignore=true
EOF

rm -f /usr/lib/calamares/modules/bootloader/main.py
mv /etc/calamares/main.py /usr/lib/calamares/modules/bootloader/main.py
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
DISTRIB_ID="Debueis Linux"
DISTRIB_RELEASE="rolling"
DISTRIB_DESCRIPTION="Debueis Linux"
EOF

mkdir -p /home/liveuser/.config/autostart
cat <<EOF > /home/liveuser/.config/autostart/calamares.desktop
[Desktop Entry]
Type=Application
Exec=pkexec calamares
Name=Debueis Linux Installer
Icon=debueis-logo
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

chown root:root /usr/share/xsessions/plasma.desktop
chown -R liveuser:liveuser /home/liveuser/.config
chmod 644 /home/liveuser/.config/autostart/calamares.desktop
chmod 644 /usr/share/xsessions/plasma-x11.desktop

pacman-key --init
pacman-key --populate archlinux
