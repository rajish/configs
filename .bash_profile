# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/.cask/bin:$HOME/.local/bin:$HOME/bin:$HOME/bin/sbt/bin:$HOME/bin/eclipse:$PATH

export PATH
export MINICOM="-c on"

TZ='Europe/Warsaw'; export TZ
