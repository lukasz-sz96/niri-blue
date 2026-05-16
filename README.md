# niri-blue

Custom Bluefin DX bootc image for a Niri + Noctalia desktop.

Base image: `ghcr.io/ublue-os/bluefin-dx:stable`

## What Makes this Raptor Different?

Here are the changes from Bluefin DX. This image is based on Bluefin DX and keeps its developer workflow, Homebrew integration, Flatpak application model, and system management tools.

### Added Packages (Build-time)

- **Niri desktop**: `niri`, `xwayland-satellite`, and `noctalia-shell` provide the primary scrollable Wayland desktop experience.
- **Wayland desktop tools**: `fuzzel`, `grim`, `slurp`, `satty`, `swappy`, `wf-recorder`, `wl-clipboard`, `cliphist`, and `wlsunset` cover launching, screenshots, recording, clipboard history, and display comfort.
- **Terminal and file tools**: Ghostty, Foot, Alacritty, Nautilus, Nautilus Python integration, and Yazi give the session sensible graphical and terminal file workflows.
- **Desktop controls and appearance**: `brightnessctl`, `pavucontrol`, `blueman`, `qt6ct`, `kvantum`, `nwg-look`, Papirus icons, Inter, and Noto fonts improve daily laptop, audio, Bluetooth, Qt, and font coverage.
- **Security and secrets**: `gnome-keyring` and Seahorse keep secret and key management available outside a default GNOME session.

### Added Applications (Runtime)

- **CLI tools (Homebrew)**: Bat, Eza, fd, ripgrep, gh, Lazygit, Neovim, Starship, Zoxide, chezmoi, htop, tmux, ShellCheck, and stress-ng are available through `ujust install-default-apps`.
- **Development tools (Homebrew)**: mise, Node.js, pnpm, Bun, Deno, TypeScript tooling, Go, uv, LuaRocks, Helix, and Micro are available through `ujust install-dev-tools`.
- **Fonts (Homebrew)**: Common Nerd Fonts are available through `ujust install-fonts`.
- **GUI apps (Flatpak)**: Browsers, GNOME utility apps, Obsidian, Flatseal, Warehouse, Mission Center, DistroShelf, Bazaar, Refine, and related desktop tools are preinstalled after first boot.

### Removed/Disabled

- No Bluefin DX components are removed.

### Configuration Changes

- Terra is installed and intentionally kept enabled for Niri and Noctalia package updates.
- `podman.socket` is enabled.
- Local Brewfiles are copied into `/usr/share/ublue-os/homebrew/`.
- Local ujust recipes are consolidated into `/usr/share/ublue-os/just/60-custom.just`.
- Flatpak preinstall files are copied into `/etc/flatpak/preinstall.d/`.
- Dotfiles are not applied automatically; `ujust apply-dotfiles` applies the `bluefin` branch from `lukasz-sz96/dotfiles`.

*Last updated: 2026-05-16*

## What Is In The Image

Build-time system packages live in `build/20-niri-noctalia.sh`.

- Niri session and Noctalia shell
- Wayland desktop helpers and portals
- Ghostty, Foot, Nautilus, Nautilus Python integration, and Yazi
- Clipboard, brightness, audio, Bluetooth, and appearance tools
- `git` and `chezmoi`

Homebrew is used for normal CLI and development tools. Flatpak is used for GUI apps.

## Build

```bash
just build
```

Build a bootable test artifact:

```bash
just build-qcow2
```

The `Containerfile` runs all numbered scripts matching `build/[0-9][0-9]-*.sh`.

## Install Or Update

Switch to the published image:

```bash
sudo bootc switch ghcr.io/lukasz-sz96/niri-blue:stable
sudo systemctl reboot
```

Update:

```bash
sudo bootc upgrade
sudo systemctl reboot
```

Roll back:

```bash
sudo bootc rollback
sudo systemctl reboot
```

## Dotfiles

Dotfiles are not applied automatically. Apply them manually after booting:

```bash
ujust apply-dotfiles
```

Useful commands:

```bash
ujust diff-dotfiles
ujust update-dotfiles
```

`ujust apply-dotfiles` runs:

```bash
chezmoi init --apply --branch bluefin lukasz-sz96/dotfiles
```

## Development Tools

Install the Homebrew development bundle:

```bash
ujust install-dev-tools
```

Neovim is in the default Brewfile. Project runtimes should be managed with `mise`; the development Brewfile includes `mise`, Node.js, `pnpm`, Bun, Deno, TypeScript language servers, Go, `uv`, and related CLI tools.

## Edit Points

- Image packages: `build/20-niri-noctalia.sh`
- Homebrew bundles: `custom/brew/*.Brewfile`
- Flatpak preinstalls: `custom/flatpaks/*.preinstall`
- ujust commands: `custom/ujust/*.just`
