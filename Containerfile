# niri-blue
#
# Custom Bluefin DX image with a Niri + Noctalia desktop layer.
# Local build scripts and runtime bundles are mounted through the ctx stage so
# they can be used during the build without being copied as source files into
# the final image.

FROM scratch AS ctx
COPY build /build
COPY custom /custom

# Bluefin DX includes GNOME, Homebrew, developer tooling, and Bluefin defaults.
FROM ghcr.io/ublue-os/bluefin-dx:stable

### /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.

# RUN rm /opt && mkdir /opt

### MODIFICATIONS
## Build scripts run in numerical order. Files ending in .example or .disabled
## are intentionally skipped.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
  --mount=type=cache,dst=/var/cache \
  --mount=type=cache,dst=/var/log \
  --mount=type=tmpfs,dst=/tmp \
  /usr/bin/bash -c 'set -euo pipefail; for script in /ctx/build/[0-9][0-9]-*.sh; do [ -f "$script" ] || continue; case "$script" in *.example|*.disabled) continue ;; esac; /usr/bin/bash "$script"; done'

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
