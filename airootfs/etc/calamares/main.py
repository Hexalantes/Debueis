#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import subprocess
import libcalamares
from libcalamares.utils import check_target_env_call, check_target_env_output

def run():
    fw_type = libcalamares.globalstorage.value("firmwareType")
    efi_directory = libcalamares.globalstorage.value("efiSystemPartition")
    if fw_type == "efi":
        return install_grub_uefi(efi_directory)
    else:
        return install_grub_bios()

def install_grub_uefi(efi_directory):
    cfg = libcalamares.job.configuration
    grub_install = cfg.get("grubInstall", "grub-install")
    grub_id = cfg.get("bootloaderEntryName", "CalamaresBoot").replace(" ", "")
    fallback = cfg.get("installEFIFallback", False)

    root_mount = libcalamares.globalstorage.value("rootMountPoint")
    efi_mount = os.path.join(root_mount, efi_directory.lstrip("/"))
    os.makedirs(efi_mount, exist_ok=True)

    cmd = [
        grub_install,
        "--target=x86_64-efi",
        "--efi-directory=/boot/efi",
        f"--bootloader-id=PardusTheArchean",
        "--recheck",
        "--removable",
    ]
    
    try:
        check_target_env_call(cmd)
    except subprocess.CalledProcessError as e:
        return ("GRUB EFI Install Failed", str(e))

    return generate_grub_cfg()

def install_grub_bios():
    cfg = libcalamares.job.configuration
    grub_install = cfg.get("grubInstall", "grub-install")

    device = libcalamares.globalstorage.value("bootLoaderInstallPath")
    if not device:
        root_partition = libcalamares.globalstorage.value("rootPartition")
        if root_partition:
            try:
                disk = check_target_env_output(["lsblk", "-no", "PKNAME", root_partition]).strip()
                device = f"/dev/{disk}"
            except Exception as e:
                return ("Disk Detection Error", str(e))
        else:
            device = "/dev/sda"

    cmd = [
        grub_install,
        "--target=i386-pc",
        "--boot-directory=/boot",
        "--recheck",
        device
    ]

    try:
        check_target_env_call(cmd)
    except subprocess.CalledProcessError as e:
        return ("GRUB BIOS Install Failed", str(e))

    return generate_grub_cfg()

def generate_grub_cfg():
    cfg = libcalamares.job.configuration
    grub_mkconfig = cfg.get("grubMkconfig", "grub-mkconfig")
    grub_cfg_path = cfg.get("grubCfg", "/boot/grub/grub.cfg")

    try:
        check_target_env_call([grub_mkconfig, "-o", grub_cfg_path])
    except subprocess.CalledProcessError as e:
        return ("GRUB Config Error", str(e))

    return None
