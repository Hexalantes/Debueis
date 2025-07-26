#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#

import os
import subprocess
import libcalamares

def run_grub_install(fw_type, efi_dir, install_hybrid):
    partitions = libcalamares.globalstorage.value("partitions")
    if not partitions:
        libcalamares.utils.warning("Partition list empty, cannot install bootloader.")
        return

    if fw_type == "efi":
        efi_bootloader_id = libcalamares.job.configuration.get("bootloaderEntryName", "GRUB")
        target = "x86_64-efi"  # çoğunlukla AMD64 sistemler için
        # grub-install komutu
        cmd = [
            "grub-install",
            "--target=" + target,
            "--efi-directory=" + efi_dir,
            "--bootloader-id=" + efi_bootloader_id,
            "--recheck",
            "--force"
        ]
        libcalamares.utils.debug(f"Running: {' '.join(cmd)}")
        libcalamares.utils.target_env_call(cmd)

    elif fw_type == "bios":
        # BIOS için disk yolunu bul
        boot_disk = None
        efi_system_partition = libcalamares.globalstorage.value("efiSystemPartition")
        if efi_system_partition:
            # Örnek: /boot/efi mount noktası varsa, bağlı disk tespiti
            find_disk_cmd = f"lsblk -no PKNAME $(df --output=source {efi_system_partition} | tail -n1)"
            disk_name = libcalamares.utils.target_env_output(["sh", "-c", find_disk_cmd]).strip()
            if disk_name:
                boot_disk = "/dev/" + disk_name

        if not boot_disk:
            # Eğer disk bulunamazsa fallback olarak /dev/sda alalım
            boot_disk = "/dev/sda"

        cmd = [
            "grub-install",
            "--target=i386-pc",
            "--recheck",
            "--force",
            boot_disk
        ]
        libcalamares.utils.debug(f"Running: {' '.join(cmd)}")
        libcalamares.utils.target_env_call(cmd)

    else:
        libcalamares.utils.warning(f"Firmware type {fw_type} not supported for grub install.")


def run_grub_mkconfig():
    output_cfg = "/boot/grub/grub.cfg"
    grub_mkconfig = libcalamares.job.configuration.get("grubMkconfig", "grub-mkconfig")
    cmd = [grub_mkconfig, "-o", output_cfg]
    libcalamares.utils.debug(f"Running: {' '.join(cmd)}")
    libcalamares.utils.target_env_call(cmd)


def run():
    fw_type = libcalamares.globalstorage.value("firmwareType")
    efi_dir = libcalamares.globalstorage.value("efiSystemPartition")
    install_hybrid = libcalamares.job.configuration.get("installHybridGRUB", False)

    libcalamares.utils.debug(f"Firmware type: {fw_type}, EFI directory: {efi_dir}")

    try:
        run_grub_install(fw_type, efi_dir, install_hybrid)
        run_grub_mkconfig()
    except subprocess.CalledProcessError as e:
        libcalamares.utils.warning(f"Bootloader install failed: {e}")
        return ("Bootloader installation error",
                f"Command {e.cmd} failed with exit code {e.returncode}")
    return None
