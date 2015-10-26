#!/bin/bash

# General installs
sudo apt-get install -y vim git curl

# Git config
git config --global user.name "atheri"
git config --global user.email "corylotze@gmail.com"
git config --global merge.tool vimdiff

# Download dotfiles
sudo rm ~/.dotfiles -r
git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".bashrc .vim"
for file in $DOTFILES; do
    sudo rm -r ~/$file
    ln -s -f $DEST/$file ~/$file
done

# Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Create directories for vim
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# Get wombat colorscheme
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/bundle/vim-wombat-scheme

# vim plugins
# Supertab
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab

# vim-rails
git clone git://github.com/tpope/vim-rails.git ~/.vim/bundle/vim-rails
git clone git://github.com/tpope/vim-bundler.git ~/.vim/bundle/vim-bundler
