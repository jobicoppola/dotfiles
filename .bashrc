# ~/.bashrc :: jcopp.cfxd.net

# only proceed for interactive shells
[ -z "$PS1" ] && return

# ignore duplicates and cmds starting with spaces
HISTCONTROL=ignoreboth

# append to history
shopt -s histappend
PROMPT_COMMAND="history -a"

# set history length
HISTSIZE=99999
HISTFILESIZE=$HISTSIZE

# case-insensitive tab-completion for paths
shopt -s nocaseglob

# lets us use ** to find files/dirs
shopt -s globstar

# hostname completion
HOSTFILE=~/.ssh/known_hosts
shopt -s hostcomplete

# set path
P1=/usr/local/bin:/sw/bin:/sw/sbin:/usr/local/sbin:/usr/local/mysql/bin
P2=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/opt/local/bin
P3=$HOME/bin:$HOME:/usr/local/php5:/usr/local/git/bin:$HOME/pear/bin
export PATH=$P1:$P2:$P3

# start ssh-agent and set sock var
if [ -s "$SSH_AUTH_SOCK" -o ! -S "$SSH_AUTH_SOCK" ]; then
  `rm -f $SSH_AUTH_SOCK`
  export SSH_AUTH_SOCK=/tmp/ssh-agent-`hostname`
  if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent -a $SSH_AUTH_SOCK -s`
    `ssh-add`
    `ssh-add ~/.ssh/id_rsa_sn`
    `ssh-add ~/.ssh/id_rsa_github`
    `ssh-add ~/.ssh/id_rsa_sn_jobot`
  fi
fi

# set editor vars to textmate
export EDITOR='~/bin/mate_wait'
export GIT_EDITOR='~/bin/mate -w11'

# ruby related
export RUBYOPT=rubygems
export GEM_HOME=$HOME/gems
export RUBYPATH=$GEM_HOME
export PATH=$PATH:$HOME/gems/bin
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# node.js
NODE_PATH=/usr/local/lib/node
export PATH=$PATH:$HOME/node_modules/.bin

# make compilers behave
export ARCHFLAGS="-arch x86_64"

# source color helper file
[ -f ~/.bash_colors ] && . ~/.bash_colors

# function to read in password
readpass(){
    echo -n >&2 "Password: "
    local was="$(stty -a | grep -ow -e '-\?echo')" pass
    stty -echo
    read pass
    stty "$was"
    echo >&2
    echo "$pass"
}

# virtualenv info
get_venv(){
    [ $VIRTUAL_ENV ] && echo "$(basename $VIRTUAL_ENV):"
}

# return current git branch
get_branch(){
    REF=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${REF#refs/heads/}")"
}

# find git status
get_status(){
    TMSG='Changes to be committed'
    SMSG='Changes not staged for commit'
    CMSG='nothing to commit (working directory clean)'
    UMSG='nothing added to commit but untracked files present'
    GSTAT=$(git status 2> /dev/null) || return
    if [[ $(echo ${GSTAT} |grep -c "$SMSG") > 0 ]]; then
        echo '?'
    elif [[ $(echo ${GSTAT} |grep -c "$TMSG") > 0 ]]; then
        echo '!'
    elif [[ $(echo ${GSTAT} |grep -c "$UMSG") > 0 ]]; then
        echo 'u'
    elif [[ $(echo ${GSTAT} |grep -c "$CMSG") > 0 ]]; then
        echo '¬'
    else
        echo 'f'
    fi
}

# set prompt
PS1="\n$BGreen\$(get_venv)$Purple\u@\h$BWhite\w$BYellow\$(get_branch)$BGreen\$(get_status)\n$Blue$ $Ecol"

# vars and paths for aws tools
[ -f ~/.awsrc ] && . ~/.awsrc

# twilio, sunlight api creds
[ -f ~/.miscrc ] && . ~/.miscrc

# source various alias files if they exist
[ -f ~/.alias ] && . ~/.alias
[ -f ~/.jc_aliases ] && . ~/.jc_aliases
[ -f ~/.sn_aliases ] && . ~/.sn_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# virtualenv
export WORKON_HOME=$HOME/venvs
VWSH=$(which virtualenvwrapper.sh)
[ -f "$VWSH" ] && . "$VWSH"

# fink
alias fink="sudo fink"
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# sportingnews
export SNELIPS=$(<~/sn/elips.lst)
export SNBLADES=$(<~/sn/bladechassis.lst)
export SNPRODWS=$(<~/sn/prod-servers-snweb.lst)

# brew completion
source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
source `brew --prefix grc`/etc/grc.bashrc

# oracle env vars
export ORACLE_HOME=/usr/local/oracle

# mysql path
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
