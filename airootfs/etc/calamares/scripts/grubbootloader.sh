disk=$(lsblk -dpno NAME,TYPE | grep disk | head -n1 | awk '{print $1}')

if [ -d /sys/firmware/efi ]; then
    echo "UEFI detected, installing grub in UEFI mode"

    efi_part=$(lsblk -dpno NAME,FSTYPE,MOUNTPOINT | grep vfat | grep "$disk" | awk '{print $1}' | head -n1)

    if [ -z "$efi_part" ]; then
      echo "EFI partition bulunamadı!"
      exit 1
    fi

    mountpoint -q /boot/efi || mount "$efi_part" /boot/efi

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Pardus --recheck --removable

    grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "BIOS detected, installing grub in BIOS mode"

    grub-install --target=i386-pc "$disk" --recheck

    grub-mkconfig -o /boot/grub/grub.cfg
fi
