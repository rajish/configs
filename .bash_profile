# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.awsenv ]; then
    . ~/.awsenv
fi

# User specific environment and startup programs

PATH=$HOME/.cask/bin:$HOME/.local/bin:$HOME/bin:$HOME/bin/sbt/bin:$HOME/bin/activator:$HOME/bin/play2:$HOME/bin/eclipse:$PATH

export PATH
export MINICOM="-c on"

# TZ='Europe/Warsaw'; export TZ
