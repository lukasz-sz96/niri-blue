# Build Scripts

This directory contains build scripts that run during image creation. Scripts are executed in numerical order.

## How It Works

Scripts are named with a number prefix (e.g., `10-build.sh`, `20-onepassword.sh`) and run in ascending order during the container build process.

## Included Scripts

- **`10-build.sh`** - Main build script for base system modifications, package installation, and service configuration
- **`20-niri-noctalia.sh`** - Installs Terra, Niri, Noctalia, and the supporting Wayland desktop packages

## Example Scripts

- **`20-onepassword.sh.example`** - Example showing how to install software from third-party RPM repositories (Google Chrome, 1Password)
- **`30-cosmic-desktop.sh.example`** - Example showing a desktop environment replacement pattern

To use an example script:
1. Remove the `.example` extension
2. The build system will automatically run it in numerical order

## Creating Your Own Scripts

Create numbered scripts for different purposes:

```bash
# 10-build.sh - Base system (already exists)
# 20-drivers.sh - Hardware drivers  
# 30-development.sh - Development tools
# 40-gaming.sh - Gaming software
# 50-cleanup.sh - Final cleanup tasks
```

### Script Template

```bash
#!/usr/bin/env bash
set -oue pipefail

echo "Running custom setup..."
# Your commands here
```

### Best Practices

- **Use descriptive names**: `20-nvidia-drivers.sh` is better than `20-stuff.sh`
- **One purpose per script**: Easier to debug and maintain
- **Clean up after yourself**: Remove temporary files and disable temporary repos
- **Test incrementally**: Add one script at a time and test builds
- **Comment your code**: Future you will thank present you

### Disabling Scripts

To temporarily disable a script without deleting it:
- Rename it with `.disabled` extension: `20-script.sh.disabled`
- Or remove execute permission: `chmod -x build/20-script.sh`

## Execution Order

The Containerfile runs numbered scripts directly:

```dockerfile
for script in /ctx/build/[0-9][0-9]-*.sh; do ...; done
```

Files ending in `.example` or `.disabled` are skipped.

By default, you can keep logic split across multiple numbered scripts.

To change behavior, you can:

1. **Modify Containerfile** to use a different entrypoint
2. **Consolidate into `10-build.sh`** if you prefer a single script

## Notes

- Scripts run as root during build
- Build context is available at `/ctx`
- Use dnf5 for package management (not dnf or yum)
- Always use `-y` flag for non-interactive installs
