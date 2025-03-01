#!/bin/bash

DOTFILES_DIR="$HOME/Repos/github.com/mischavandenburg/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"

create_directories() {
  local directories=("$@")
  for dir in "${directories[@]}"; do
    mkdir -p "$dir"
  done
}

create_symlinks() {
  local items=("$@")
  for item in "${items[@]}"; do
    IFS=':' read -r source target <<<"$item"
    if [ -L "$target" ]; then
      echo "Removing existing symlink $target"
      unlink "$target"
    elif [ -d "$target" ]; then
      echo "Warning: $target is a directory. Skipping..."
      continue
    elif [ -e "$target" ]; then
      echo "Warning: $target already exists. Skipping..."
      continue
    fi
    ln -s "$DOTFILES_DIR/$source" "$target"
    echo "Created symlink for $source"
  done
}

common_directories=(
  "$XDG_CONFIG_HOME/alacritty"
  "$XDG_CONFIG_HOME/alacritty/themes"
  "$XDG_CONFIG_HOME/skhd"
  "$XDG_CONFIG_HOME/k9s"
  "$XDG_CONFIG_HOME/qutebrowser"
  "$XDG_CONFIG_HOME/waybar"
  "$XDG_CONFIG_HOME/hypr"
)

common_items=(
  "alacritty.toml:$XDG_CONFIG_HOME/alacritty/alacritty.toml"
  "k9s/skin.yml:$XDG_CONFIG_HOME/k9s/skin.yml"
  ".inputrc:$HOME/.inputrc"
  ".tmux.conf:$HOME/.tmux.conf"
  "nvim:$XDG_CONFIG_HOME/nvim"
  "skhdrc:$XDG_CONFIG_HOME/skhd/skhdrc"
  ".zprofile:$HOME/.zprofile"
  ".zshrc:$HOME/.zshrc"
  "qutebrowser/config.py:$XDG_CONFIG_HOME/qutebrowser/config.py"
  "waybar/config.jsonc:$XDG_CONFIG_HOME/waybar/config.jsonc"
  "waybar/style.css:$XDG_CONFIG_HOME/waybar/style.css"
  "hypr/hyprland.conf:$XDG_CONFIG_HOME/hypr/hyprland.conf"
  "hypr/hypridle.conf:$XDG_CONFIG_HOME/hypr/hypridle.conf"
  "hypr/hyprlock.conf:$XDG_CONFIG_HOME/hypr/hyprlock.conf"
)

create_directories "${common_directories[@]}"
create_symlinks "${common_items[@]}"

# MacOS specific setup
if [[ "$OSTYPE" == darwin* ]]; then
  macos_directories=(
    "$HOME/.qutebrowser"
  )
  macos_items=(
    "qutebrowser/config.py:$HOME/.qutebrowser/config.py"
  )
  create_directories "${macos_directories[@]}"
  create_symlinks "${macos_items[@]}"
fi

# ln -sf "$PWD/.bash_profile" "$HOME"/.bash_profile
# ln -sf "$PWD/.bashrc" "$HOME"/.bashrc

# Zettelkasten
# This one's a little tricky on MacOS because the path contains a space. It needs to be stored as an array,
# and when called it needs to be quoted.
# export ZETTELKASTEN=("/Users/mischa/Library/Mobile Documents/iCloud~md~obsidian/Documents/second-brain-01-07-23")
# export ZETTELKASTEN=("/Users/mischa/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettelkasten")
# ln -sf "$ZETTELKASTEN" ~/Zettelkasten
#
# iCloud
# export ICLOUD=("/Users/mischa/Library/Mobile Documents/com~apple~CloudDocs")
# ln -sf "$ICLOUD" ~/icloud

# Packages

# install brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# get the font out of the way first, it's the most annoying

# install for Mac using brew.
# brew install --cask font-iosevka-nerd-font
# brew install --cask font-ubuntu-mono-nerd-font

# For ubuntu:
# mkdir -p $HOME/.local/share/fonts
# cp $PWD/fonts/UbuntuMono* $HOME/.local/share/fonts

# brew packages Mac
# brew install --cask alacritty
# amethyst fzf nvim exa hugo bash-completion@2 newsboat kubectl starship

# ubuntu packages apt
# sudo apt install ripgrep gh

# ubuntu apt neovim setup
# sudo apt install gcc g++ unzip

# ubuntu brew for vim and neovim setup
# sudo apt install fd fzf kubectl kubectx derailed/k9s/k9s starship

# ubuntu brew for neovim setup
# brew install neovim go lazygit

# ubuntu specific notes
# create symbolic link to neovim from vim when not using neovim on
# Ubuntu systems, because I use the v alias everywhere.
# sudo ln -sf /usr/bin/vim /usr/bin/nvim

# Arch Linux

# pacman packages:
# sudo pacman -Syu zsh zsh-completions ttf-ubuntu-mono-nerd fzf npm unzip tmux ripgrep fd

# set up prompt
# mkdir -p "$HOME/.zsh"
# git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
