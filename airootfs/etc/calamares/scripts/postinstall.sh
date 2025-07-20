#!/bin/bash

echo "[postinstall] liveuser ve autologin temizleniyor..."

# liveuser'ı sil
chroot "$1" userdel -rf liveuser || true

# sudoers kuralını sil
chroot "$1" rm -f /etc/sudoers.d/liveuser || true

# sddm autologin konfigini sil
chroot "$1" rm -f /etc/sddm.conf.d/autologin.conf || true

echo "[postinstall] Temizlik tamamlandı."
