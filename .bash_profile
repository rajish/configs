# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export MINICOM="-c on"

alias ll="ls -lahF"
TZ='Europe/Warsaw'; export TZ
