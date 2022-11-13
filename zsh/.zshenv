export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/go
export GIT_EDITOR="nvim"
export EDITOR="nvim"
export DOTFILES=$HOME/.dotfiles

export MOZ_ENABLE_WAYLAND=1

export PATH=$PATH:$HOME/.local/share/pnpm
export PATH=$PATH:$HOME/.local/.npm-global/bin
export PATH=$PATH:$HOME/.local/scripts
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/go/bin
export PATH=$PATH:$HOME/go/bin

export NVM_DIR="/usr/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
