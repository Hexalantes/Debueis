#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import subprocess
import libcalamares
from libcalamares.utils import check_target_env_call, check_target_env_output

def run():
    fw_type = libcalamares.globalstorage.value("firmwareType")
    efi_boot_loader = libcalamares.job.configuration.get("efiBootLoader", "grub")
    efi_directory = libcalamares.globalstorage.value("efiSystemPartition")
    partitions = libcalamares.globalstorage.value("partitions")

    if not partitions:
        return ("Bootloader Error", "No partitions defined.")

    if fw_type == "efi":
        return install_grub_uefi(efi_directory)
    else:
        return install_grub_bios()

def install_grub_uefi(efi_directory):
    root_mount = libcalamares.globalstorage.value("rootMountPoint")
    efi_mount = os.path.join(root_mount, efi_directory.lstrip("/"))

    if not os.path.exists(efi_mount):
        os.makedirs(efi_mount)

    cmd = [
        "grub-install",
        "--target=x86_64-efi",
        f"--efi-directory={efi_mount}",
        "--bootloader-id=PardusTheArchean",
        "--recheck",
        "--no-nvram",
        "--removable"
    ]

    try:
        check_target_env_call(cmd)
    except subprocess.CalledProcessError as e:
        return ("GRUB EFI Install Failed", str(e))

    return generate_grub_cfg()

def install_grub_bios():
    device = libcalamares.globalstorage.value("bootLoaderInstallPath")
    if not device:
        return ("Bootloader Error", "No BIOS install device specified.")

    cmd = [
        "grub-install",
        "--target=i386-pc",
        f"--boot-directory=/boot",
        "--recheck",
        device
    ]

    try:
        check_target_env_call(cmd)
    except subprocess.CalledProcessError as e:
        return ("GRUB BIOS Install Failed", str(e))

    return generate_grub_cfg()

def generate_grub_cfg():
    try:
        check_target_env_call(["grub-mkconfig", "-o", "/boot/grub/grub.cfg"])
    except subprocess.CalledProcessError as e:
        return ("GRUB Config Error", str(e))

    return None
