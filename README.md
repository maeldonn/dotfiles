# Dotfiles

My personal dotfiles, managed with chezmoi. Feel free to copy and adapt them.

## Install

Initialize the dotfiles without applying them:

```bash
chezmoi init maeldonn
```

Set the machine-specific values in:

```toml
# ~/.config/chezmoi/chezmoi.toml

[data]
email = "your-email@example.com"
```

Review the changes:

```bash
chezmoi diff
```

Then apply them:

```bash
chezmoi apply
```

## Commit Signing

Git commit and tag signing is enabled by default with the SSH key at
`~/.ssh/id_ed25519.pub`. To use a GPG key instead, set `gpg_key` to its
fingerprint in your chezmoi data:

```toml
# ~/.config/chezmoi/chezmoi.toml

[data]
gpg_key = "0123456789ABCDEF"
```

Leave `gpg_key` empty or unset to keep SSH signing.

## Update

Review and apply the configuration interactively:

```bash
chezmoi apply --interactive
```
