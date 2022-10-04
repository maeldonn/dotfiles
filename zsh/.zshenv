export XDG_CONFIG_HOME=$HOME/.config

export GOPATH=$HOME/go
export GIT_EDITOR="nvim"
export DOTFILES=$HOME/.dotfiles

export NVM_DIR="/usr/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH=$PATH:$HOME/.local/.npm-global/bin
export PATH=$PATH:$HOME/.local/scripts
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/go/bin
export PATH=$PATH:$HOME/go/bin
