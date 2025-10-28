#!/usr/bin/env bash

link_file () {
  if [ -e "$HOME/$1" ]; then mv "$HOME/$1" "$HOME/$1.backup"; fi
  ln -s "$(pwd)/$1" "$HOME/$1"
}

# link files
link_file Brewfile 
link_file .editorconfig
link_file .gitconfig
link_file .gitignore
link_file .tmux.conf
link_file .zprofile
link_file .zshrc
link_file .config/nvim/init.lua
link_file .config/ghostty/config
