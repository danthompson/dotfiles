#!/usr/bin/env bash

link_file () {
  if [ -e "$HOME/$1" ]; then mv "$HOME/$1" "$HOME/$1.backup"; fi
  ln -s "$(pwd)/$1" "$HOME/$1"
}

# Download plug.vim and put it in the "autoload" directory.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Link files
link_file .bash_profile
link_file .bashrc
link_file .gemrc
link_file .gitconfig
link_file .gitignore
link_file .inputrc
link_file .rspec
link_file .tmux.conf
link_file .vimrc
link_file Brewfile
