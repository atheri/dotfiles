#!/bin/bash

# General installs
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "environment.sh: LINUX"
  sudo apt-get install -y vim git curl zsh
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  chsh -s "$(which zsh)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "environment.sh: MAC"
  if ! brew -v >/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew bundle --file=mac/Brewfile
  chsh -s /bin/zsh
elif [[ "$OSTYPE" == "msys" ]]; then
  echo "environment.sh: WINDOWS + GITBASH"
else
  echo "environment.sh: SUPPORTED SYSTEM NOT DETECTED"
  exit 1
fi

# oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then rm -rf ~/.oh-my-zsh; fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# Git config
git config --global user.name "Cory Lotze"
git config --global user.email "cory.lotze@clearcapital.com"
git config --global merge.tool vimdiff
git config --global --add difftool.prompt false

# Download dotfiles
if [ -d ~/.dotfiles ]; then rm -rf ~/.dotfiles; fi
git clone git@github.com:atheri/dotfiles.git ~/.dotfiles

# Sym links
DEST=~/.dotfiles
DOTFILES=".vim .zshrc .p10k.zsh"
for file in $DOTFILES; do
  if [ -d ~/"$file" ]; then rm -rf ~/"$file"; fi
  ln -s -f "$DEST/$file" ~/"$file"
done

# Setup alias file
FILE="aliases.zsh"
if [ -d ~/$FILE ]; then rm -rf ~/$FILE; fi
ln -s -f "$DEST/$FILE" "$HOME/.oh-my-zsh/custom/$FILE"
ln -s -f "$DEST/$FILE" "$HOME/.$FILE"

# Create directories for vim
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# placeholder secrets file
touch ~/.secrets.sh

# Get wombat colorscheme
if [ -d ~/.vim/colors ]; then rm -rf ~/.vim/colors; fi
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors
rm -f ~/.vim/colors/README.md
mv ~/.vim/colors/colors/wombat.vim ~/.vim/colors/
rm -rf ~/.vim/colors/colors

echo "----------------------------------------------------"
echo "---------- Restart for zsh to take effect ----------"
echo "----------------------------------------------------"
