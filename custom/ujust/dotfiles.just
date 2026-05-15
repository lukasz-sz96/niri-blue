# vim: set ft=make :
#################
### dotfiles.just
#################

# Apply Lukasz's Bluefin dotfiles with chezmoi
[group('Dotfiles')]
apply-dotfiles:
    chezmoi init --apply --branch bluefin lukasz-sz96/dotfiles

# Show pending chezmoi changes
[group('Dotfiles')]
diff-dotfiles:
    chezmoi diff

# Update the checked-out chezmoi source and apply changes
[group('Dotfiles')]
update-dotfiles:
    chezmoi update
