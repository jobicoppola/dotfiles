#
#>=-</.|.\>=-------------------------------------------------------------------
#`
#  ~/.bashrc :: jcopp.cfxd.net
#•
#|\>=--------------------------------------------------------------------------
#`


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
VIM=$(which vim)
export EDITOR="${VIM}"
export GIT_EDITOR="${VIM}"
export GIT_MERGE_AUTOEDIT=no

# use `bat` as manpage formatter
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_CONFIG_PATH=~/.batconfig


# path setup
#=-----------------------------------------------------------------------------

if [[ "$OS" == Darwin ]]; then
    COREUTILS=/usr/local/opt/coreutils/libexec/gnubin
    GREP=/usr/local/opt/grep/libexec/gnubin
    PY=/usr/local/opt/python/libexec/bin
    P1=$PY:$COREUTILS:$GREP
    P2=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
    P3=$HOME/bin:$HOME/go/bin
    export PATH=$P1:$P2:$P3
else
    P1=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin
    P2=$HOME/bin
    export PATH=$P1:$P2
fi


# ssh setup
#=-----------------------------------------------------------------------------

# start ssh-agent and set sock var
if [ -s "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
  rm -f "$SSH_AUTH_SOCK"
  SSH_AUTH_SOCK=/tmp/ssh-agent-$(hostname)
  export SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
  if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval ssh-agent -a "$SSH_AUTH_SOCK" -s
    ssh-add
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
    # mojave; fyi only
    SYSTEM_GEMS=/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/gems/2.3
    SYSTEM_RUBY_EXEC=/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby
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


# go
#=-----------------------------------------------------------------------------

gobin=~/go/bin
goenv=~/go/env
[ -d "$goenv" ] || mkdir -p "$goenv"
export GOBIN="${gobin}"
export GOENV="${goenv}"


# virtualenv
#=-----------------------------------------------------------------------------

vepy_version=$(python -V |awk '{print $2}' |cut -d. -f1-2)
vepy_path="/Users/$(whoami)/Library/Python/${vepy_version}"
vepy_wrapper="${vepy_path}/bin/virtualenvwrapper.sh"
export PATH=$PATH:${vepy_path}/bin
export WORKON_HOME=$HOME/venvs
export VIRTUALENVWRAPPER_PYTHON=$(which python)
export VIRTUALENVWRAPPER_SCRIPT="${vepy_wrapper}"
[ -f "$VIRTUALENVWRAPPER_SCRIPT" ] && . "$VIRTUALENVWRAPPER_SCRIPT" || echo 'No VIRTUALENVWRAPPER'
#vepy_ww=$(which virtualenvwrapper.sh)
#vepy_wsh=${vepy_ww:=$vepy_wrapper}
#[ -f "${vepy_wrapper}" ] && . "${vepy_wrapper}" || echo 'No VIRTUALENVWRAPPER'


# prompt setup
#=-----------------------------------------------------------------------------

get_venv(){
    [ "${VIRTUAL_ENV}" ] && echo "$(basename ${VIRTUAL_ENV}):"
}

get_current_git_branch(){
    REF=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "(${REF#refs/heads/})"
}

get_git_status(){
    CMSG='nothing to commit'
    TMSG='Changes to be committed'
    SMSG='Changes not staged for commit'
    UMSG='nothing added to commit but untracked files present'
    GSTAT=$(git status 2> /dev/null) || return
    if [[ $(echo "${GSTAT}" |grep -c "${SMSG}") > 0 ]]; then
        echo '?'
    elif [[ $(echo "${GSTAT}" |grep -c "${TMSG}") > 0 ]]; then
        echo '!'
    elif [[ $(echo "${GSTAT}" |grep -c "${UMSG}") > 0 ]]; then
        echo 'u'
    elif [[ $(echo "${GSTAT}" |grep -c "${CMSG}") > 0 ]]; then
        echo '¬'
    else
        echo 'f'
    fi
}

# bring in named colors
[ -f ~/.bash_colors ] && . ~/.bash_colors

# shellcheck disable=SC2154
PS1_TIME="\n${ClockColor}\t${Blue}"
PS1_VENV="${Bold}${VenvColor}\$(get_venv)"
PS1_USER="\u@\h${BWhite}\w${BYellow}"
PS1_USER_MAC="${EC}${UserColor}jcopp@macbot"
PS1_CWD="${Bold}${CwdColor}\w"
PS1_GIT="${BranchColor}\$(get_current_git_branch)${BGreen}\$(get_git_status)${EC}"
PS1_END="\n${EC}${Gray}$ ${EC}"
PS1_END_MAC="\n${Bold}${DollarColor}$ ${EC}"

# now actually set the prompt
if [[ "$OS" == Darwin ]] && [[ "$(hostname)" != *bot ]]; then
    # override ugly hostname on work machines
    PS1="${PS1_TIME}|${PS1_VENV}${PS1_USER_MAC}${PS1_CWD}${PS1_GIT}${PS1_END_MAC}"
else
    PS1="${PS1_TIME}$Gray|${PS1_VENV}${PS1_USER}${PS1_GIT}${PS1_END}"
fi


# source aliases and other custom config files
#=-----------------------------------------------------------------------------

[ -f ~/.alias ] && . ~/.alias
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_aliases_user ] && . ~/.bash_aliases_user
[ -f ~/.bash_sensible ] && . ~/.bash_sensible

[ -f ~/.miscrc ] && . ~/.miscrc
[ -f ~/.awsrc ] && . ~/.awsrc

# mac specific
if [[ "$OS" == Darwin ]]; then
    [ -f ~/.bash_aliases_osx ] && . ~/.bash_aliases_osx

    # brew completions
    localbrew=$(brew --prefix)/etc
    [ -f ${localbrew}/bash_completion ] && . ${localbrew}/bash_completion
    [ -f ${localbrew}/grc.bashrc ] && . ${localbrew}/grc.bashrc

    # other completions
    [ -f ~/.fzf.bash ] && . ~/.fzf.bash
    [ -f ~/bash_completion.d/ssh ] && . ~/bash_completion.d/ssh
    [ -f ~/bash_completion.d/terraform ] && . ~/bash_completion.d/terraform
    [ -f ~/bash_completion.d/helm ] && . ~/bash_completion.d/helm  # helm completion bash > bash_completion.d/helm
    [ -f ~/bash_completion.d/oc ] && . ~/bash_completion.d/oc      # oc completion bash > bash_completion.d/oc

    # awscli completions
    [ -f "$(which aws_completer)" ] && complete -C "$(which aws_completer)" aws
fi


# rg and fzf helpers
#=-----------------------------------------------------------------------------

# set default - also used by vim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --no-follow --glob "!.git"'

rg_command='rg --column --line-number --no-heading --fixed-strings '
rg_command+='--ignore-case --no-ignore --hidden --color "always" --glob "!.git"'
rg_command_dirs='rg --no-heading --ignore-case --no-ignore --hidden --color "always"'

sf() {
    local files
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"
    files=$(eval $rg_command $search \
            | fzf --ansi --multi --reverse \
            | awk -F ':' '{print $1":"$2":"$3}')
    [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

sd() {
    local directories
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"
    directories=$(eval $rg_command_dirs -g \"*$search*\" --files \
                  | sort -u \
                  | fzf --ansi --multi --reverse)
    [[ -n "$directories" ]] && ${EDITOR:-vim} $directories
}

sfd(){
    local files directories fd all
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"

    files=$(eval $rg_command $search | awk -F ':' '{print $1":"$2":"$3}')
    directories=$(eval $rg_command_dirs -g "*$search*" --files | sort -u)

    fd=( "${directories[@]}" "${files[@]}" )
    all=$(printf '%s\n' "${fd[@]}" | fzf --ansi --multi --reverse)
    [[ -n "$all" ]] && ${EDITOR:-vim} $all
}


# from fzf wiki examples
#=-----------------------------------------------------------------------------

fco(){
    # checkout git branch/tag
    local tags branches target
    tags=$(git tag \
           | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(git branch --all \
               | grep -v HEAD \
               | sed "s/.* //" \
               | sed "s#remotes/[^/]*/##" \
               | sort -u \
               | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$( (echo "$tags"; echo "$branches") \
               | fzf-tmux -l50 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

fcoc(){
    # checkout git commit
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    # +s --no-sort ; +m --no-multi ; --tac "reverse order of the input"
    commit=$(echo "$commits" | fzf --tac +s +m --exact) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

fcor(){
    # checkout git branch (incl remote), sorted by most recent commit, limit n
    local branches branch limit=50
    branches=$(git for-each-ref \
               --count=$limit \
               --sort=-committerdate \
               refs/heads/ \
               --format="%(refname:short)") &&
    branch=$(echo "$branches" \
             | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fcs(){
    # get git commit sha
    # example usage: git rebase -i `fcs`
    local commits commit
    commits=$(git log --color=always \
              --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
    echo -n $(echo "$commit" | sed "s/ .*//")
}

fshow(){
    # git commit browser
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
        | fzf --ansi --no-sort --reverse --tiebreak=index \
        --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
            (grep -o '[a-f0-9]\{7\}' | head -1 |
            xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
            {}
FZF-EOF"
}


# switch tmux pane (@george-b)
#=-----------------------------------------------------------------------------

ftpane(){
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


# try to securely deal with passwords
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

setpass(){
    local id="$1" group="$2" pw=""
    if [[ "$OS" == Darwin ]]; then
        pw=$(readpass)
        security delete-generic-password -a "$group" -s "$id" 2> /dev/null
        security add-generic-password -a "$group" -s "$id" -w $pw
    fi
}

getpass(){
    local id="$1" group="$2"
    if [[ "$OS" == Darwin ]]; then
        security find-generic-password -a "$group" -s "$id" -w
    fi
}


# work setup
#=-----------------------------------------------------------------------------

[ -f ~/.workrc ] && . ~/.workrc
