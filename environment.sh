#!/bin/bash

# get sudo password primed
sudo -i exit;

pinned_apps=(
  "org.gnome.Nautilus.desktop"
  "google-chrome.desktop"
)

sep() {
  cols=$(tput cols)
  symbol="="
  text="$symbol$symbol$symbol $1 "
  remain_n=$(( cols-${#text} ))
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
  sudo apt install -y git curl zsh tmux gcc make golang-go
  sudo chsh -s "$(which zsh)" "$(whoami)"
  # neovim - build from source deps
  sudo apt install -y ninja-build gettext cmake curl build-essential git
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
DOTFILES=".zshrc .p10k.zsh .k9s"
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

sep "fzf"
go install github.com/junegunn/fzf@latest

sep "ghostty"
GHOSTTY_CONFIG_FILE="$HOME/.config/ghostty/config"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
if [ -d $GHOSTTY_CONFIG_FILE ]; then rm -rf $GHOSTTY_CONFIG_FILE; fi
ln -s -f "$DEST/ghostty/config" $GHOSTTY_CONFIG_FILE
pinned_apps+=("com.mitchellh.ghostty.desktop")

sep "blur-my-shell"
git clone https://github.com/aunetx/blur-my-shell $HOME/source_build/blur-my-shell
(
  cd ~/source_build/blur-my-shell
  make install
)
sudo apt install -y gnome-shell-extensions

sep "update pinned apps"
formatted_string=$(printf "'%s', " "${pinned_apps[@]}")
final_string="[${formatted_string%, }]"
gsettings set org.gnome.shell favorite-apps "$final_string"

sep "neovim"
git clone https://github.com/neovim/neovim $HOME/source_build/neovim
(
  cd ~/source_build/neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
)

echo "----------------------------------------------------"
echo "---------- Restart for zsh to take effect ----------"
echo "----------------------------------------------------"
