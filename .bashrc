source ~/.secrets.sh

# CCP
#export CCP_ROOT=$HOME/code/ccp
#source $CCP_ROOT/ccp

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "LINUX"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.bashrc_mac
else
  echo "Supported system not detected"
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable vi binds
set -o vi

# Includes current folder in path variable
export PATH=$PATH:.
export PATH=$PATH:$JAVA_HOME
export PATH=$PATH:$INTELLIJ_HOME
export PATH='/usr/local/sbin':$PATH
export PATH='/opt/openmpi/bin':$PATH
export LD_LIBRARY_PATH='/opt/openmpi/lib'
export KOPS_MFA_ARN='arn:aws:iam::388917641422:mfa/cory.lotze'

# Variables for CC automation suite
export CC_SAAS_UI_AUTOMATION=$HOME'/bitbucket/saas-ui-automation'
export DOCKER=$CC_SAAS_UI_AUTOMATION'/docker/out'
export PATH=$(brew --prefix openvpn)/sbin:$PATH

# Makes terminal support 256 colors
export TERM="xterm-256color"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# fzf options
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --ignore-case' # case insensitive fzf
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export AWS_DEFAULT_REGION='us-west-2'

# proxy
#export http_proxy="http://proxy.clearcollateral.com:8080"
#export https_proxy="http://proxy.clearcollateral.com:8080"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
