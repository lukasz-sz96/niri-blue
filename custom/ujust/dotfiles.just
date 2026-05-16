# vim: set ft=make :
#################
### dotfiles.just
#################

# Apply Lukasz's Bluefin dotfiles with chezmoi
[group('Dotfiles')]
apply-dotfiles:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v chezmoi >/dev/null; then
        brew install chezmoi
    fi
    chezmoi init --apply --branch bluefin lukasz-sz96/dotfiles

# Show pending chezmoi changes
[group('Dotfiles')]
diff-dotfiles:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v chezmoi >/dev/null; then
        brew install chezmoi
    fi
    chezmoi diff

# Update the checked-out chezmoi source and apply changes
[group('Dotfiles')]
update-dotfiles:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v chezmoi >/dev/null; then
        brew install chezmoi
    fi
    chezmoi update
