#!/usr/bin/env bash
set -oue pipefail

# Terra repo for Noctalia
dnf5 install -y --nogpgcheck \
  --repofrompath "terra,https://repos.fyralabs.com/terra$releasever" \
  terra-release

# Niri + Noctalia + useful Niri desktop bits
dnf5 install -y \
  niri \
  xwayland-satellite \
  noctalia-shell \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  fuzzel \
  alacritty \
  wl-clipboard \
  cliphist \
  brightnessctl \
  pavucontrol \
  blueman \
  wlsunset \
  qt6ct \
  nwg-look \
  gnome-keyring \
  seahorse
