#!/bin/bash
set -e

echo "[postinstall] liveuser siliniyor..."

chroot "$1" userdel -rf liveuser || true

echo "[postinstall] liveuser silindi."
