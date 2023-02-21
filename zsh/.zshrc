source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from github
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# Personal aliases
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias l="exa"
alias ls="exa -ah"
alias ll="exa -lah"
alias cat="bat"

# Ricing
pfetch
