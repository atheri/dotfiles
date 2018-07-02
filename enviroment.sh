#!/bin/bash

# General installs
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo apt-get install -y vim git curl
elif [[ "$OSTYPE" == "darwin"* ]]; then
  if ! brew -v > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew install vim
  brew install git
  brew install bash-completion
  brew install fzf
else
  echo "Supported system not detected"
  exit 1
fi

# Git config
git config --global user.name "atheri"
git config --global user.email "corylotze@gmail.com"
git config --global merge.tool vimdiff
git config --global --add difftool.prompt false

# Download dotfiles
sudo rm ~/.dotfiles -rf
git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".bashrc .bashrc_mac .vim"
for file in $DOTFILES; do
    sudo rm -r ~/$file
    ln -s -f $DEST/$file ~/$file
done

# Create directories for vim
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# Get wombat colorscheme
sudo rm ~/.vim/colors -rf
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors
sudo rm ~/.vim/colors/README.md -f
mv ~/.vim/colors/colors/wombat.vim ~/.vim/colors/
rm ~/.vim/colors/color -rf

source ~/.bashrc
