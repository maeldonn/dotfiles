all: clean deploy

clean:
	@echo 'Cleaning dotfiles...'
	@stow -D alacritty
	@stow -D bin
	@stow -D nvim
	@stow -D personal
	@stow -D sway
	@stow -D tmux
	@stow -D waybar
	@stow -D wofi
	@stow -D zsh
	@echo 'Dotfiles cleaned!'

deploy:
	@echo 'Deploying dotfiles...'
	@stow alacritty
	@stow bin
	@chmod +x ~/.local/scripts/*.sh
	@stow nvim
	@stow personal
	@stow sway
	@stow tmux
	@stow waybar
	@stow wofi
	@stow zsh
	@echo 'Dotfiles deployed!'
