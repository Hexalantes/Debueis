#!/bin/bash

if ! lspci | grep -i nvidia > /dev/null; then
    zenity --info --title="NVIDIA Installer" --text="No NVIDIA GPU detected on this system."
    exit 1
fi

DRIVER=$(zenity --list --title="NVIDIA Driver Installer" \
                --text="Select the driver you want to install:" \
                --radiolist \
                --column="Select" --column="Driver" \
                TRUE "nvidia-dkms" \
                FALSE "nvidia" \
                FALSE "nouveau")

if [ -z "$DRIVER" ]; then
    zenity --info --title="Cancelled" --text="Installation cancelled."
    exit 0
fi

zenity --question --title="Confirmation" --text="Selected driver: $DRIVER\nProceed with installation?"
if [ $? -ne 0 ]; then
    zenity --info --title="Cancelled" --text="Installation cancelled."
    exit 0
fi

(
    echo "10" ; sleep 0.5
    echo "# Updating package list..." ; sleep 0.5
    sudo pacman -Syu --noconfirm &> /tmp/nvidia-install.log
    echo "50" ; sleep 0.5
    echo "# Installing driver..." ; sleep 0.5

    case $DRIVER in
        "nvidia-dkms")
            sudo pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings &>> /tmp/nvidia-install.log
            ;;
        "nvidia")
            sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings &>> /tmp/nvidia-install.log
            ;;
        "nouveau")
            sudo pacman -S --noconfirm xf86-video-nouveau &>> /tmp/nvidia-install.log
            ;;
    esac

    echo "90" ; sleep 0.5
    echo "# Verifying installation..." ; sleep 0.5

    if [[ "$DRIVER" == "nouveau" ]]; then
        if lsmod | grep -q nouveau; then
            echo "100"
            exit 0
        else
            echo "100"
            exit 1
        fi
    else
        if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi &>/dev/null; then
            echo "100"
            exit 0
        else
            echo "100"
            exit 1
        fi
    fi
) | zenity --progress --title="NVIDIA Driver Installer" --percentage=0 --auto-close

if [[ $? -eq 0 ]]; then
    zenity --question --title="Completed" --text="Driver installation is complete. Do you want to reboot now?"
    if [ $? -eq 0 ]; then
        sudo reboot
    fi
else
    zenity --error --title="Installation Failed" --text="Driver installation failed. Check /tmp/nvidia-install.log for details."
fi
