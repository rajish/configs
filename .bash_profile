# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.jiraenv  ] ; then
    . ~/.jiraenv
fi

# User specific environment and startup programs

PATH=$HOME/.cask/bin:$HOME/.local/bin:$HOME/bin:$HOME/bin/sbt/bin:$HOME/bin/activator:$HOME/bin/play2:$HOME/bin/eclipse:$PATH

export PATH
export MINICOM="-c on"

# TZ='Europe/Warsaw'; export TZ

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export PATH="/usr/local/sbin:/usr/local/bin:/usr/local/opt/python/libexec/bin:$PATH"
