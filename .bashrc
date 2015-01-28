# ~/.bashrc :: jcopp.cfxd.net

# only proceed for interactive shells
[ -z "$PS1" ] && return

# determine os
OS=$(uname)

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
if [[ "$OS" == Darwin ]]; then
    COREUTILS=/usr/local/opt/coreutils/libexec/gnubin
    P1=/usr/local/bin:$COREUTILS:/usr/local/sbin:/usr/local/mysql/bin
    P2=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/opt/local/bin
    P3=$HOME/bin:$HOME:/usr/local/php5:/usr/local/git/bin:$HOME/pear/bin
    export PATH=$P1:$P2:$P3
    # prepend postgresql
    export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH

else
    P1=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin
    P2=$HOME/bin
    export PATH=$P1:$P2
fi

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

# set editor vars
export EDITOR=$(which vim)
export GIT_EDITOR=$(which vim)
export GIT_MERGE_AUTOEDIT=no

# ruby related
export RUBYOPT=rubygems
export GEM_HOME=$HOME/gems
export RUBYPATH=$GEM_HOME
export GEM_PATH=$GEM_HOME
export PATH=$PATH:$GEM_HOME/bin
if [[ "$OS" == Darwin ]]; then
    # fyi only
    SYSTEM_GEMS=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8
    SYSTEM_RUBY_EXEC=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby
fi

# use rbenv to manage ruby versions
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# use bundler to manage ruby applications
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# packer
export PATH=$PATH:$HOME/packer

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
    CMSG='nothing to commit'
    TMSG='Changes to be committed'
    SMSG='Changes not staged for commit'
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
PS1_VENV="\n$BGreen\$(get_venv)$Purple"
PS1_USER="\u@\h$BWhite\w$BYellow"
PS1_GIT="\$(get_branch)$BGreen\$(get_status)$Ecol"
PS1_END="\n$Blue$ $Ecol"
PS1="${PS1_VENV}${PS1_USER}${PS1_GIT}${PS1_END}"

# vars and paths for aws tools
[ -f ~/.awsrc ] && . ~/.awsrc

# twilio, sunlight api creds
[ -f ~/.miscrc ] && . ~/.miscrc

# source various alias files if they exist
[ -f ~/.alias ] && . ~/.alias
[ -f ~/.jc_aliases ] && . ~/.jc_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# sportingnews
[ -f ~/.snrc ] && . ~/.snrc
[ -f ~/.sn_aliases ] && . ~/.sn_aliases

# mac specific
if [[ "$OS" == Darwin ]]; then
    # source osx aliases file
    [ -f ~/.bash_aliases_osx ] && . ~/.bash_aliases_osx

    # override ugly prompt on perform machines
    if [[ "$(hostname)" == L0100* ]]; then
        PS1="${PS1_VENV}jcopp@macbot$BWhite\w$BYellow${PS1_GIT}${PS1_END}"
    fi
    # prepend homebrew location to manpath
    export MANPATH=/usr/local/Cellar:$MANPATH
    # brew completion
    [ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion
    [ -f `brew --prefix grc`/etc/grc.bashrc ] && . `brew --prefix grc`/etc/grc.bashrc
    [ -f ~/bash_completion.d/knife ] && . ~/bash_completion.d/knife
    [ -f ~/bash_completion.d/berkshelf ] && . ~/bash_completion.d/berkshelf
fi

# virtualenv
export WORKON_HOME=$HOME/venvs
VWSH=$(which virtualenvwrapper.sh)
[ -f "$VWSH" ] && . "$VWSH"

# clojure
export VIMCLOJURE_SERVER_JAR="$HOME/lib/vimclojure/server.jar"

# set db related env vars
set_db_vars(){
    # oracle
    export ORACLE_HOME=/usr/local/oracle
    # mysql path
    export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
}

