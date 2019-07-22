#!/bin/bash

# General installs
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "environment.sh: LINUX"
  sudo apt-get install -y vim git curl zsh
  chsh -s $(which zsh)
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "environment.sh: MAC"
  if ! brew -v > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew install vim
  brew install git
  #brew install bash-completion
  brew install fzf
  brew install zsh zsh-completions
  chsh -s /bin/zsh
elif [[ "$OSTYPE" == "msys" ]]; then
  echo "environment.sh: WINDOWS + GITBASH"

else
  echo "environment.sh: SUPPORTED SYSTEM NOT DETECTED"
  exit 1
fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Git config
git config --global user.name "atheri"
git config --global user.email "corylotze@gmail.com"
git config --global merge.tool vimdiff
git config --global --add difftool.prompt false

# Download dotfiles
rm ~/.dotfiles -rf
git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".bashrc .bashrc_mac .vim"
for file in $DOTFILES; do
    rm -rf ~/$file
    ln -s -f $DEST/$file ~/$file
done

# Create directories for vim
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# Get wombat colorscheme
rm ~/.vim/colors -rf
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors
rm ~/.vim/colors/README.md -f
mv ~/.vim/colors/colors/wombat.vim ~/.vim/colors/
rm ~/.vim/colors/colors -rf

source ~/.bashrc
