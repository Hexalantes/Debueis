#!/bin/bash

if ! lspci | grep -i nvidia > /dev/null; then
    zenity --info --title="NVIDIA Yükleyici" --text="Sisteminizde NVIDIA GPU bulunamadı."
    exit 1
fi

DRIVER=$(zenity --list --title="NVIDIA Driver Yükleyici" \
                --text="Hangi sürücüyü yüklemek istersiniz? (Emin değilseniz nvidia-dkms seçiniz.)" \
                --radiolist \
                --column="Seçim" --column="Sürücü" \
                TRUE "nvidia-dkms" \
                FALSE "nvidia" \
                FALSE "nouveau")
                
if [ -z "$DRIVER" ]; then
    exit 0
fi

case $DRIVER in
    "nvidia-dkms")
        sudo pacman -Syu --noconfirm nvidia-dkms nvidia-utils nvidia-settings
        ;;
    "nvidia")
        sudo pacman -Syu --noconfirm nvidia nvidia-utils nvidia-settings
        ;;
    "nouveau")
        sudo pacman -Syu --noconfirm xf86-video-nouveau
        ;;
esac

# Bilgilendirme
zenity --info --title="NVIDIA Yükleyici" --text="Seçilen sürücü yüklendi. Lütfen sistemi yeniden başlatın."
