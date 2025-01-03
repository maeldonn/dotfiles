all: clean deploy
clean:
	@echo 'Cleaning dotfiles...'
	@stow -D alacritty
	@stow -D applications
	@stow -D bin
	@stow -D code
	@stow -D ghostty
	@stow -D hyprland
	@stow -D kitty
	@stow -D lf
	@stow -D nvim
	@stow -D mako
	@stow -D neofetch
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
	# @stow applications
	@stow bin
	@chmod +x ~/.local/bin/*
	@stow code
	@stow hyprland
	@stow ghostty
	@stow kitty
	@stow lf
	@stow nvim
	@stow mako
	@stow neofetch
	@stow personal
	@stow spotify
	@stow sway
	@stow tmux
	@stow waybar
	@stow wlogout
	@stow wofi
	@stow zsh
	@echo 'Dotfiles deployed!'
