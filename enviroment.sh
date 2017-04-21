#!/bin/bash

# General installs
sudo apt-get install -y vim git curl

# Git config
git config --global user.name "atheri"
git config --global user.email "corylotze@gmail.com"
git config --global merge.tool vimdiff

# Download dotfiles
sudo rm ~/.dotfiles -rf
git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".bashrc .vim"
for file in $DOTFILES; do
    sudo rm -r ~/$file
    ln -s -f $DEST/$file ~/$file
done

# Create directories for vim
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# Get wombat colorscheme
sudo rm ~/.vim/colors -rf
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/
sudo rm ~/.vim/README.md -f


