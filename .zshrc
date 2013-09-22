# add ~/bin to the PATH
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"


# aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias grep="grep --color=always"
alias ls="ls --color=auto"
alias e="vim"
alias q="exit"
alias wq="exit"
alias q!="exit"
alias shelllevel='echo `echo $SHLVL`'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(archlinux git command-not-found mercurial python pip extract history systemd)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/gaby/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:~/.gem/ruby/1.9.1/bin

# ----------------------------------------------
# USEFUL FUNCTIONS
# ----------------------------------------------

lslast()
{
    echo "`ls -rtf  $1| tail -1`"
}


logview()
{
    ccze -A < $1 | less -R
}

logtail()
{
    tail -f $1 | ccze
}

pj() {
  cd $1 && $EDITOR .
}


# ---------------------------------------------------------------------------
# Rebinding
# ---------------------------------------------------------------------------

bindkey "\033[1;*H" beginning-of-line
bindkey "[1;4H" beginning-of-line
bindkey "[1;*F" end-of-line
bindkey "[1;4F" end-of-line
# bindkey "^[[3~" delete-char
# bindkey "^W" backward-delete-word
bindkey "^X^E" edit-command-line

# -----------------------------------------------------------------------------
# Environment variables
# -----------------------------------------------------------------------------

TERM=rxvt-256color
VIM_SHARE_DIR="/usr/share/vim/vim73"
PAGER="less -X -M"
WORKSPACE=~/project/
