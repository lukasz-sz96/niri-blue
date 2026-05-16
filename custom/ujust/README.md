# niri-blue ujust Commands

This directory contains local Just recipes that are installed into the image and exposed through `ujust`.

During the build, `build/10-build.sh` concatenates all `*.just` files into:

```text
/usr/share/ublue-os/just/60-custom.just
```

Bluefin DX already provides the shared ujust framework and common system commands. These files should contain only niri-blue additions.

## Included Files

- `custom-apps.just` - Homebrew bundle shortcuts, JetBrains Toolbox, and one generic Flatpak installer.
- `custom-system.just` - Small maintenance helpers and aliases into Bluefin DX development group setup.
- `dotfiles.just` - Manual chezmoi commands for `lukasz-sz96/dotfiles`.

## Available Commands

```bash
ujust install-default-apps
ujust install-dev-tools
ujust install-fonts
ujust install-all-brew
ujust jetbrains-toolbox
ujust install-flatpak APP_ID
ujust benchmark
ujust configure-dev-groups
ujust clean-containers
ujust update-and-reboot
ujust apply-dotfiles
ujust diff-dotfiles
ujust update-dotfiles
```

## Rules

- Do not install RPM packages from ujust commands. Add system packages at build time in `build/*.sh`.
- Use Homebrew for host CLI tools and Flatpak for graphical applications.
- Keep commands user-facing and specific; avoid placeholder recipes in the image.
- Use `pkexec` or `sudo` only when root access is required.

## Testing

```bash
just --justfile custom/ujust/custom-apps.just --list
just --justfile custom/ujust/custom-system.just --list
just --justfile custom/ujust/dotfiles.just --list
```
