# niri-blue

Custom Bluefin DX bootc image for a Niri + Noctalia desktop.

Base image:

```dockerfile
FROM ghcr.io/ublue-os/bluefin-dx:stable
```

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
sudo bootc switch ghcr.io/<owner>/<image>:stable
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

Neovim, `node`, and `luarocks` are in the default Brewfile. Project runtimes should be managed with `mise`; the development Brewfile includes `mise`, `pnpm`, Bun, Deno, TypeScript language servers, Go, `uv`, and related CLI tools.

## Edit Points

- Image packages: `build/20-niri-noctalia.sh`
- Homebrew bundles: `custom/brew/*.Brewfile`
- Flatpak preinstalls: `custom/flatpaks/*.preinstall`
- ujust commands: `custom/ujust/*.just`
