#!/bin/bash
set -e

echo "Pardus The Archean Alpha"
echo "Hexalantes & Heizen"
echo "Minimal Kuruluma Hoş Geldiniz"
read -p "Cihazınız için kullanıcı adı giriniz: " username
read -p "Cihazınızı temsil etmesini istediğiniz ismi giriniz: " hostname
lsblk
read -p "Disk giriniz (örn: /dev/sda): " disk
read -p "Dosya sistemi giriniz (ext4/btrfs/xfs/f2fs): " fs
read -p "MB cinsinden Swap boyutu giriniz (1 GB için 1024, 2 GB için 2048, 4 GB için 4096, 8 GB için 8192): " swapsize

wipefs -af "$disk"
parted -s "$disk" mklabel msdos
parted -s "$disk" mkpart primary fat32 1MiB 513MiB
parted -s "$disk" set 1 boot on
parted -s "$disk" mkpart primary 513MiB 100%

boot="${disk}1"
root="${disk}2"

mkfs.fat -F32 "$boot"
case "$fs" in
  ext4) mkfs.ext4 "$root" ;;
  btrfs) mkfs.btrfs "$root" ;;
  xfs) mkfs.xfs "$root" ;;
  f2fs) mkfs.f2fs "$root" ;;
  *) exit 1 ;;
esac

mount "$root" /mnt
mkdir -p /mnt/boot
mount "$boot" /mnt/boot

if [[ "$swapsize" -gt 0 ]]; then
  dd if=/dev/zero of=/mnt/swapfile bs=1M count="$swapsize" status=progress
  chmod 600 /mnt/swapfile
  mkswap /mnt/swapfile
fi

pacstrap -K /mnt base linux linux-firmware linux-headers \
  sudo nano bash-completion \
  networkmanager grub efibootmgr \
  plasma kde-applications konsole dolphin spectacle sddm firefox\
  xkeyboard-config

genfstab -U /mnt >> /mnt/etc/fstab
if [[ "$swapsize" -gt 0 ]]; then
  echo "/swapfile none swap defaults 0 0" >> /mnt/etc/fstab
fi

arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
hwclock --systohc
sed -i 's/#tr_TR.UTF-8 UTF-8/tr_TR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=tr_TR.UTF-8' > /etc/locale.conf
echo "$hostname" > /etc/hostname
cat >> /etc/hosts <<EOL
127.0.0.1 localhost
::1       localhost
127.0.1.1 $hostname.localdomain $hostname
EOL
useradd -m -G wheel -s /bin/bash $username
echo "root şifresi giriniz"
passwd
echo "$username için şifre giriniz:"
passwd $username
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable sddm
echo 'KEYMAP=trq' > /etc/vconsole.conf
EOF

read -p "AUR yardımcı kurulsun mu? (yay/paru/hayır): " aur
arch-chroot /mnt /bin/bash <<EOF
sudo -u $username bash <<AURHELP
cd ~
if [[ "$aur" == "yay" ]]; then
  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
elif [[ "$aur" == "paru" ]]; then
  git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm
fi
AURHELP
EOF

rm -f /mnt/etc/os-release
cp ./os-release /mnt/etc/os-release
cp ./pardus-logo.png /mnt/usr/share/pixmaps/pardus-logo.png

echo "Kurulum tamamlandı. Reboot edebilirsiniz."
