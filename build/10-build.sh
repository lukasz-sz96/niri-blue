#!/usr/bin/bash

set -euo pipefail

###############################################################################
# Main Build Script
###############################################################################
# Installs local runtime declarations and small system-level defaults.
###############################################################################

# Enable nullglob for all glob operations to prevent failures on empty matches
shopt -s nullglob

echo "::group:: Copy Custom Files"

# Copy Brewfiles to standard location
install -d /usr/share/ublue-os/homebrew/
cp /ctx/custom/brew/*.Brewfile /usr/share/ublue-os/homebrew/

# Consolidate local ujust recipes. Bluefin's base image provides the shared
# ujust entrypoint; this file contains only niri-blue additions.
install -d /usr/share/ublue-os/just/
: > /usr/share/ublue-os/just/60-custom.just
while IFS= read -r justfile; do
  printf "\n\n# %s\n" "$(basename "$justfile")" >> /usr/share/ublue-os/just/60-custom.just
  cat "$justfile" >> /usr/share/ublue-os/just/60-custom.just
done < <(find /ctx/custom/ujust -iname "*.just" -type f | sort)

# Copy Flatpak preinstall files
install -d /etc/flatpak/preinstall.d/
cp /ctx/custom/flatpaks/*.preinstall /etc/flatpak/preinstall.d/

echo "::endgroup::"

echo "::group:: Install Packages"

# Install packages using dnf5
# Example: dnf5 install -y tmux

# Example using COPR with isolated pattern:
# copr_install_isolated "ublue-os/staging" package-name

echo "::endgroup::"

echo "::group:: System Configuration"

# Enable/disable systemd services
systemctl enable podman.socket
# Example: systemctl mask unwanted-service

echo "::endgroup::"

# Restore default glob behavior
shopt -u nullglob

echo "Custom build complete!"
