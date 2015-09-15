#!/bin/bash

# General installs
sudo apt-get install -y vim git

# Git config
git config --global user.name "atheri"
git config --global user.email "corylotze@gmail.com"
git config --global merge.tool vimdiff

git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".bashrc .vim"
for file in $DOTFILES; do
    ln -s -f $DEST/$file ~/$file
done
