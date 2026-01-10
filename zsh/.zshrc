# source $HOME/.antigen/antigen.zsh
source '/usr/share/zsh-antidote/antidote.zsh'

# Initialize antidote's dynamic mode, which changes `antidote bundle`
# from static mode
source <(antidote init)

# Bundles from github
antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting
antidote bundle zsh-users/zsh-completions

# Load the theme.
antidote bundle romkatv/powerlevel10k

# Set up fzf key bindings and fuzzy fuzzy completion
source <(fzf --zsh)

# Personal aliases
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias l="eza"
alias ls="eza -ah"
alias ll="eza -lah"
alias cat="bat"
