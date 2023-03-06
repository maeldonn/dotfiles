all: clean deploy

clean:
	@echo 'Cleaning dotfiles...'
	@stow -D alacritty
	@stow -D bin
	@stow -D lf
	@stow -D nvim
	@stow -D personal
	@stow -D spotify
	@stow -D sway
	@stow -D tmux
	@stow -D waybar
	@stow -D wlogout
	@stow -D wofi
	@stow -D zsh
	@echo 'Dotfiles cleaned!'

deploy:
	@echo 'Deploying dotfiles...'
	@stow alacritty
	@stow bin
	@chmod +x ~/.local/scripts/*
	@stow lf
	@stow nvim
	@stow personal
	@stow spotify
	@stow sway
	@stow tmux
	@stow waybar
	@stow wlogout
	@stow wofi
	@stow zsh
	@echo 'Dotfiles deployed!'
