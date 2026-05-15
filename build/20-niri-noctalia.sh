#!/usr/bin/bash
set -euo pipefail

# Terra repo for Noctalia
dnf5 install -y --nogpgcheck \
  --repofrompath "terra,https://repos.fyralabs.com/terra\$releasever" \
  terra-release

# Niri + Noctalia + useful Niri desktop bits
dnf5 install -y \
  niri \
  xwayland-satellite \
  noctalia-shell \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  fuzzel \
  ghostty \
  ghostty-nautilus \
  foot \
  nautilus \
  nautilus-python \
  yazi \
  alacritty \
  grim \
  slurp \
  satty \
  swappy \
  wf-recorder \
  mpv \
  mpv-mpris \
  wl-clipboard \
  cliphist \
  brightnessctl \
  pavucontrol \
  blueman \
  wlsunset \
  qt6ct \
  kvantum \
  nwg-look \
  papirus-icon-theme \
  rsms-inter-fonts \
  google-noto-sans-fonts \
  google-noto-serif-fonts \
  google-noto-emoji-fonts \
  google-noto-sans-cjk-fonts \
  google-noto-serif-cjk-fonts \
  git \
  chezmoi \
  gnome-keyring \
  seahorse

rpm -q \
  niri \
  noctalia-shell \
  ghostty \
  ghostty-nautilus \
  foot \
  nautilus \
  nautilus-python \
  yazi \
  grim \
  slurp \
  satty \
  swappy \
  wf-recorder \
  mpv \
  mpv-mpris \
  papirus-icon-theme \
  rsms-inter-fonts \
  google-noto-sans-fonts \
  google-noto-serif-fonts \
  google-noto-emoji-fonts \
  google-noto-sans-cjk-fonts \
  google-noto-serif-cjk-fonts \
  kvantum
command -v niri >/dev/null
command -v ghostty >/dev/null
command -v foot >/dev/null
command -v nautilus >/dev/null
command -v yazi >/dev/null
command -v grim >/dev/null
command -v slurp >/dev/null
command -v satty >/dev/null
command -v swappy >/dev/null
command -v wf-recorder >/dev/null
command -v mpv >/dev/null
command -v chezmoi >/dev/null

if [[ ! -f /usr/share/wayland-sessions/niri.desktop ]]; then
  echo "niri.desktop was not installed under /usr/share/wayland-sessions" >&2
  exit 1
fi
