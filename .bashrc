#>=-</.|.\>=-------------------------------------------------------------------
#
#  ~/.bashrc :: jcopp.cfxd.net
#
#\\<<=-------------------------------------------------------------------------

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

# make compilers behave
export ARCHFLAGS="-arch x86_64"

# set editor vars
export EDITOR=$(which vim)
export GIT_EDITOR=$(which vim)
export GIT_MERGE_AUTOEDIT=no


# path setup
#=-----------------------------------------------------------------------------

if [[ "$OS" == Darwin ]]; then
    COREUTILS=/usr/local/opt/coreutils/libexec/gnubin
    PY=/usr/local/opt/python/libexec/bin
    P1=$PY:/usr/local/bin:$COREUTILS:/usr/local/sbin:/usr/local/mysql/bin
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


# ssh setup
#=-----------------------------------------------------------------------------

# start ssh-agent and set sock var
if [ -s "$SSH_AUTH_SOCK" -o ! -S "$SSH_AUTH_SOCK" ]; then
  rm -f $SSH_AUTH_SOCK
  export SSH_AUTH_SOCK=/tmp/ssh-agent-$(hostname)
  if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval ssh-agent -a $SSH_AUTH_SOCK -s
    ssh-add
    ssh-add ~/.ssh/id_rsa_github
  fi
fi


# ruby related
#=-----------------------------------------------------------------------------

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


# node.js
#=-----------------------------------------------------------------------------

NODE_PATH=/usr/local/lib/node
export PATH=$PATH:$HOME/node_modules/.bin


# virtualenv
#=-----------------------------------------------------------------------------

export WORKON_HOME=$HOME/venvs
VWSH=$(which virtualenvwrapper.sh)
[ -f "$VWSH" ] && . "$VWSH"


# prompt setup
#=-----------------------------------------------------------------------------

get_venv(){
    [ $VIRTUAL_ENV ] && echo "$(basename $VIRTUAL_ENV):"
}

get_current_git_branch(){
    REF=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${REF#refs/heads/}")"
}

get_git_status(){
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

# bring in named colors
[ -f ~/.bash_colors ] && . ~/.bash_colors

PS1_VENV="\n$BGreen\$(get_venv)$Purple"
PS1_USER="\u@\h$BWhite\w$BYellow"
PS1_GIT="\$(get_current_git_branch)$BGreen\$(get_git_status)$Ecol"
PS1_END="\n$Blue$ $Ecol"

# now actually set the prompt
if [[ "$OS" == Darwin ]] && [[ "$(hostname)" == L0100* ]]; then
    # override ugly hostname on perform machines
    PS1="${PS1_VENV}jcopp@macbot$BWhite\w$BYellow${PS1_GIT}${PS1_END}"
else
    PS1="${PS1_VENV}${PS1_USER}${PS1_GIT}${PS1_END}"
fi


# aliases
#=-----------------------------------------------------------------------------

[ -f ~/.alias ] && . ~/.alias
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_aliases_jc ] && . ~/.bash_aliases_jc

[ -f ~/.miscrc ] && . ~/.miscrc
[ -f ~/.awsrc ] && . ~/.awsrc

# perform
[ -f ~/.pserc ] && . ~/.pserc
[ -f ~/.bash_aliases_pse ] && . ~/.bash_aliases_pse

# mac specific
if [[ "$OS" == Darwin ]]; then
    [ -f ~/.bash_aliases_osx ] && . ~/.bash_aliases_osx

    # brew completion
    [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
    [ -f $(brew --prefix grc)/etc/grc.bashrc ] && . $(brew --prefix grc)/etc/grc.bashrc
    [ -f ~/bash_completion.d/ssh ] && . ~/bash_completion.d/ssh
fi


# rg and fzf helpers
#=-----------------------------------------------------------------------------

rg_command='rg --column --line-number --no-heading --fixed-strings '
rg_command+='--ignore-case --no-ignore --hidden --follow --color "always"'
rg_command_dirs='rg --ignore-case --no-ignore --hidden --follow --color "always"'

sf() {
    local files
    if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
    printf -v search "%q" "$*"
    files=$(eval $rg_command $search \
            | fzf --ansi --multi --reverse \
            | awk -F ':' '{print $1":"$2":"$3}')
    [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

sd() {
    local directories
    if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
    printf -v search "%q" "$*"
    directories=$(eval $rg_command_dirs -g "*$search*" --files \
                  | sort \
                  | fzf --ansi --multi --reverse)
    [[ -n "$directories" ]] && ${EDITOR:-vim} $directories
}

sfd(){
    local files directories fd all
    if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
    printf -v search "%q" "$*"

    files=$(eval $rg_command $search | awk -F ':' '{print $1":"$2":"$3}')
    directories=$(eval $rg_command_dirs -g "*$search*" --files | sort -u)

    fd=( "${files[@]}" "${directories[@]}" )
    all=$(printf '%s\n' "${fd[@]}" | fzf --ansi --multi --reverse)
    [[ -n "$all" ]] && ${EDITOR:-vim} $all
}


# switch tmux pane (@george-b)
#=-----------------------------------------------------------------------------

ftpane() {
    local panes current_window current_pane target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_pane=$(tmux display-message -p '#I:#P')
    current_window=$(tmux display-message -p '#I')

    target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

    target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
    target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

    if [[ $current_window -eq $target_window ]]; then
        tmux select-pane -t ${target_window}.${target_pane}
    else
        tmux select-pane -t ${target_window}.${target_pane} &&
        tmux select-window -t $target_window
    fi
}


# securely read in password
#=-----------------------------------------------------------------------------

readpass(){
    echo -n >&2 "Password: "
    local was="$(stty -a | grep -ow -e '-\?echo')" pass
    stty -echo
    read pass
    stty "$was"
    echo >&2
    echo "$pass"
}
