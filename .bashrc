export PATH=$PATH:~/.gem/ruby/1.9.1/bin

TERM=xterm-256color

shopt -s expand_aliases

alias setkb='setxkbmap'
alias ls='ls --color=auto'
alias vi='vim'
export EDITOR='vim'

# modified commands
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias ..='cd ..'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet --inet6'
alias pg='ps -Af | grep $1'

# privileged access
if [ $UID -ne 0 ]; then
    alias svim='sudo vim'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
fi

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


# ajouter ~/bin dans le PATH si celui-ci existe (indispensable)
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

# ----------------------------------------------
# USEFUL FUNCTIONS
# ----------------------------------------------

logview()
{
    ccze -A < $1 | less -R
}

logtail()
{
    tail -f $1 | ccze
}
