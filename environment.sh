#!/bin/bash

# get sudo password primed
sudo -i exit;

COLS=$(tput cols)

sep() {
  symbol="="
  text="$symbol$symbol$symbol $1 "
  remain_n=$(( COLS-${#text} ))
  fill=""
  for (( i=0; i<remain_n; i++ ))
  do
    fill=$fill$symbol
  done
  printf "%s%s\\n" "$text" "$fill"
}

# General installs
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "environment.sh: LINUX"
  sep "apt base"
  sudo apt update
  sudo apt install -y vim git curl zsh tmux gcc make golang-go
  sudo chsh -s "$(which zsh)" "$(whoami)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "environment.sh: MAC"
  if ! brew -v >/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew bundle --file=mac/Brewfile
  sudo chsh -s /bin/zsh
elif [[ "$OSTYPE" == "msys" ]]; then
  echo "environment.sh: WINDOWS + GITBASH"
else
  echo "environment.sh: SUPPORTED SYSTEM NOT DETECTED"
  exit 1
fi

# Git config
sep "git config"
git config --global user.name "Cory Lotze"
git config --global user.email "cory.lotze@redwoodmaterials.com"
git config --global merge.tool vimdiff
git config --global --add difftool.prompt false

# oh-my-zsh
sep "oh-my-zsh"
if [ -d ~/.oh-my-zsh ]; then rm -rf ~/.oh-my-zsh; fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# Download dotfiles
sep "download dotfiles"
if [ -d ~/.dotfiles ]; then rm -rf ~/.dotfiles; fi
git clone https://github.com/atheri/dotfiles.git ~/.dotfiles

# Sym links
sep "sym links"
DEST=~/.dotfiles
DOTFILES=".vim .zshrc .p10k.zsh .k9s"
for file in $DOTFILES; do
  if [ -d ~/"$file" ]; then rm -rf ~/"$file"; fi
  ln -s -f "$DEST/$file" ~/"$file"
done

# Setup alias file
sep "alias file"
FILE="aliases.zsh"
if [ -d ~/$FILE ]; then rm -rf ~/$FILE; fi
ln -s -f "$DEST/$FILE" "$HOME/.oh-my-zsh/custom/$FILE"
ln -s -f "$DEST/$FILE" "$HOME/.$FILE"

# placeholder secrets file
touch ~/.secrets.sh

# Create directories for vim
sep "vim config"
mkdir -p ~/.vim/.undo ~/.vim/.backup ~/.vim/.swap

# Get wombat colorscheme
if [ -d ~/.vim/colors ]; then rm -rf ~/.vim/colors; fi
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors
rm -f ~/.vim/colors/README.md
mv ~/.vim/colors/colors/wombat.vim ~/.vim/colors/
rm -rf ~/.vim/colors/colors

sep "fzf"
go install github.com/junegunn/fzf@latest

sep "ghostty"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

echo "----------------------------------------------------"
echo "---------- Restart for zsh to take effect ----------"
echo "----------------------------------------------------"
