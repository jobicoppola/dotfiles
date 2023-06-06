# shellcheck shell=bash
#
#>=-</.|.\>=-------------------------------------------------------------------
#
#-
# ~/.bashrc :: jcopp.cfxd.net
#=-----------------------------------------------------------------------------
#`
[ -z "$PS1" ] && return  # only proceed for interactive shells


#-
# set some vars
#=-----------------------------------------------------------------------------
#`
OS=$(uname)  # determine os

# command history
HISTCONTROL=ignoreboth       # ignore duplicates and cmds starting with spaces
shopt -s histappend          # append to history
PROMPT_COMMAND="history -a"  # write history from current shell every prompt
HISTSIZE=99999               # set history length
HISTFILESIZE=$HISTSIZE

# case-insensitive tab-completion for paths
shopt -s nocaseglob

# lets us use ** to find files/dirs
shopt -s globstar

# hostname completion
HOSTFILE=~/.ssh/known_hosts
shopt -s hostcomplete

# for using `rg` and `fd` instead of grep and find
fd=$(which fd) fd="${fd:-find}"
rg=$(which rg) rg="${rg:-grep}"


#-
# export some vars
#=-----------------------------------------------------------------------------
#`
export ARCHFLAGS="-arch x86_64" # make compilers behave

# set editor vars
VIM=$(which vim)
export EDITOR="${VIM}"
export GIT_EDITOR="${VIM}"
export GIT_MERGE_AUTOEDIT=no

# use `bat` as manpage formatter
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_CONFIG_PATH=~/.batconfig


#-
# path setup
#=-----------------------------------------------------------------------------
#`
if [[ "$OS" == Darwin ]]; then
    COREUTILS=/usr/local/opt/coreutils/libexec/gnubin
    GREP=/usr/local/opt/grep/libexec/gnubin
    PY=/usr/local/opt/python/libexec/bin
    P1=$PY:$COREUTILS:$GREP
    P2=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
    P3=$HOME/bin:$HOME/go/bin:$HOME/.cargo/bin
    export PATH=$P1:$P2:$P3
else
    P1=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin
    P2=$HOME/bin
    export PATH=$P1:$P2
fi


#-
# ssh setup
#=-----------------------------------------------------------------------------
#`
if [ -s "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
  rm -f "$SSH_AUTH_SOCK"
  SSH_AUTH_SOCK=/tmp/ssh-agent-$(hostname)
  export SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
  if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval ssh-agent -a "$SSH_AUTH_SOCK" -s
    ssh-add
  fi
fi


#-
# ruby, nodejs, go, python, virtualenvwrapper
#=-----------------------------------------------------------------------------
#`
export RUBYOPT=rubygems
export GEM_HOME=$HOME/gems
export RUBYPATH=$GEM_HOME
export GEM_PATH=$GEM_HOME
export PATH=$PATH:$GEM_HOME/bin

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

# node path
export NODE_PATH=/usr/local/lib/node_modules
export PATH=$PATH:$HOME/node_modules/.bin

# go dirs
gobin=~/go/bin goenv=~/go/env
[ -d "$goenv" ] || mkdir -p "$goenv"
export GOBIN="${gobin}"
export GOENV="${goenv}"

# python and virtualenvwrapper paths
vepy=$(which python)
vepy_version=$(python -V | awk '{print $2}' | cut -d. -f1-2)
vepy_path=/Users/$(whoami)/Library/Python/${vepy_version}
vepy_wrapper=${vepy_path}/bin/virtualenvwrapper.sh
#
export PATH=$PATH:${vepy_path}/bin
export WORKON_HOME=$HOME/venvs
export VIRTUALENVWRAPPER_PYTHON=${vepy}
export VIRTUALENVWRAPPER_SCRIPT=${vepy_wrapper}

# check for virtualenvwrapper
[ -f "$VIRTUALENVWRAPPER_SCRIPT" ] && . "$VIRTUALENVWRAPPER_SCRIPT" || echo 'No VIRTUALENVWRAPPER'


#-
# prompt setup
#=-----------------------------------------------------------------------------
#`

# functions for displaying git info in the prompt
#
get_venv(){
    [ "${VIRTUAL_ENV}" ] && echo "$(basename "$VIRTUAL_ENV"):"
}

get_git_branch_current(){
    local ref
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "${ref#refs/heads/}"
}

get_git_branch_current_for_prompt(){
    local ref
    ref=$(get_git_branch_current 2> /dev/null) || return
    echo "($ref)"
}

get_git_branch_default(){
    local ref
    ref=$(git symbolic-ref --short refs/remotes/origin/HEAD 2> /dev/null) || return
    echo "$ref" | awk -F/ '{print $2}'
}

get_git_status(){
    CMSG='nothing to commit'
    TMSG='Changes to be committed'
    SMSG='Changes not staged for commit'
    UMSG='nothing added to commit but untracked files present'
    GSTAT=$(git status 2> /dev/null) || return
    if [[ $(echo "${GSTAT}" | grep -c "${SMSG}") -gt 0 ]]; then
        echo '?'
    elif [[ $(echo "${GSTAT}" | grep -c "${TMSG}") -gt 0 ]]; then
        echo '!'
    elif [[ $(echo "${GSTAT}" | grep -c "${UMSG}") -gt 0 ]]; then
        echo 'u'
    elif [[ $(echo "${GSTAT}" | grep -c "${CMSG}") -gt 0 ]]; then
        echo '¬'
    else
        echo 'f'
    fi
}

# bring in named colors
[ -f ~/.bash_colors ] && . ~/.bash_colors

# shellcheck disable=SC2154
CLOCK_COLOR="$COLOR_71"
PIPE_COLOR="$GRAY"
VENV_COLOR="$GREEN"
USER_COLOR="$COLOR_132"
CWD_COLOR="$COLOR_72"
BRANCH_COLOR="$COLOR_173"
STATUS_COLOR="$COLOR_149"
DOLLAR_COLOR="$COLOR_244" # force gray to override any theme
user_mac='jcopp@macbot' # manually set user section of prompt on macs

# shellcheck disable=SC2154
PS1_TIME="\n${CLOCK_COLOR}\t${PIPE_COLOR}"
PS1_VENV="${VENV_COLOR}\$(get_venv)"
PS1_USER="\u@\h${BWHITE}\w${BYELLOW}" # linux
PS1_USER_MAC="${EC}${USER_COLOR}${user_mac}" # mac
PS1_CWD="${CWD_COLOR}\w"
PS1_GIT="${BRANCH_COLOR}\$(get_git_branch_current_for_prompt)"
PS1_GIT+="${STATUS_COLOR}\$(get_git_status)${EC}"
PS1_END="\n${EC}${GRAY}$ ${EC}" # linux
PS1_END_MAC="\n${DOLLAR_COLOR}$ ${EC}" # mac

# now actually set the prompt
if [[ "$OS" == Darwin ]] && [[ "$(hostname)" != *bot ]]; then
    # macos
    PS1="${PS1_TIME}|${PS1_VENV}${PS1_USER_MAC}${PS1_CWD}${PS1_GIT}${PS1_END_MAC}"
else
    # linux
    PS1="${PS1_TIME}$GRAY|${PS1_VENV}${PS1_USER}${PS1_GIT}${PS1_END}"
fi


#-
# source aliases, completions and other custom config files
#=-----------------------------------------------------------------------------
#`
[ -f ~/.alias ] && . ~/.alias
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_aliases_user ] && . ~/.bash_aliases_user
[ -f ~/.bash_sensible ] && . ~/.bash_sensible
[ -f ~/.miscrc ] && . ~/.miscrc
[ -f ~/.awsrc ] && . ~/.awsrc

# http status codes
[ -f ~/.http-status-codes ] && . ~/.http-status-codes

# mac specific
if [[ "$OS" == Darwin ]]; then
    [ -f ~/.bash_aliases_osx ] && . ~/.bash_aliases_osx

    # homebrew paths
    brewpath=$(brew --prefix)
    brewconf=${brewpath}/etc

    # homebrew completions
    bash_completions=${brewconf}/profile.d/bash_completion.sh
    git_completions=${brewconf}/bash_completion.d/git-completion.bash
    grc_completions=${brewconf}/grc.bashrc
    [ -L "$bash_completions" ] && . "$bash_completions"
    [ -f "$grc_completions" ] && . "$grc_completions"
    [ -f "$git_completions" ] && . "$git_completions"

    # awscli completions
    [ -f "$(which aws_completer)" ] && complete -C "$(which aws_completer)" aws

    # fzf installer
    "${brewpath}/opt/fzf/install" --key-bindings --completion --no-update-rc >/dev/null 2>&1

    # fzf completions
    [ -f ~/.fzf.bash ] && . ~/.fzf.bash

    # ssh completions
    [ -f ~/bash_completion.d/ssh ] && . ~/bash_completion.d/ssh

    # terraform completions `terraform-docs completion bash`
    terraform_completions=~/bash_completion.d/terraform
    terraform_docs_completions=~/bash_completion.d/terraform-docs
    [ -f "$terraform_completions" ] && . "$terraform_completions"
    [ -f "$terraform_docs_completions" ] && . "$terraform_docs_completions"

    # kubectl completions `kubectl completion bash`
    kubectl_completions=~/bash_completion.d/kubectl
    [ -f "$kubectl_completions" ] && . "$kubectl_completions"
fi


#-
# rg, fzf, fasd
#=-----------------------------------------------------------------------------
#`
#
rg_command='rg --column --line-number --no-heading --fixed-strings '
rg_command+='--ignore-case --no-ignore --hidden --color "always" --glob "!.git"'
rg_command_dirs='rg --no-heading --ignore-case --no-ignore --hidden --color "always"'

# set default - also used by vim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --no-follow --glob "!.git"'


#-
# rg, fzf, fasd functions - some custom, some from fzf wiki examples
#=-----------------------------------------------------------------------------
#`
#
sf(){
    # search for files matching provided string
    # open selected files in default editor
    #
    local files
    #
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"
    files=$(eval "$rg_command" "$search" \
            | fzf --ansi --multi --reverse \
            | awk -F ':' '{print $1":"$2":"$3}')
    # shellcheck disable=SC2086
    [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

sd(){
    # search for directories matching provided string
    # open selected dirs in default editor
    #
    local directories
    #
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"
    directories=$(eval "$rg_command_dirs" -g \"*"$search"*\" --files -l \
                  | sort -u \
                  | fzf --ansi --multi --reverse)
    # shellcheck disable=SC2086
    [[ -n "$directories" ]] && ${EDITOR:-vim} $directories
}

sfd(){
    # search for files and directories matching provided string
    # open selected in default editor
    #
    local files directories fd all
    #
    if [ "$#" -lt 1 ]; then echo "Must provide search string"; return 1; fi
    printf -v search "%q" "$*"
    files=$(eval "$rg_command" "$search" | awk -F ':' '{print $1":"$2":"$3}')
    directories=$(eval "$rg_command_dirs" -g "*$search*" --files | sort -u)
    fd=( "${directories[@]}" "${files[@]}" )
    all=$(printf '%s\n' "${fd[@]}" | fzf --ansi --multi --reverse)
    # shellcheck disable=SC2086
    [[ -n "$all" ]] && ${EDITOR:-vim} $all
}

cdfd(){
    # cd via fzf - cd into dir selected from fzf list
    #
    # fzf also provides similar functionality for many commands, with **
    # e.g. `cd **<TAB>` or `vi **<TAB>`
    #
    local dir fd
    #
    fd=$(which fd)
    fd="${fd:-find}"
    #
    if [[ "$fd" == find ]]; then
        dir=$($fd "${1:-.}" -path '*/\.*' -prune -o -type d -print 2>/dev/null \
            | fzf --no-multi) \
            && cd "$dir" || return
    else
        dir=$($fd --prune --type d "${1:-.}" 2>/dev/null \
            | fzf --no-multi) \
            && cd "$dir" || return
    fi
}

cdff(){
    # cd via fzf - select file from fzf list and cd into dir containing the file
    #
    local file fzf_preview_cmd
    #
    fzf_preview_cmd='bat --color=always --theme=zenburn {}'
    #
    # +m --no-multi "disable multi select"
    file="$(fzf \
        --no-multi \
        --query="$*" \
        --preview="${fzf_preview_cmd}" \
        --preview-window='right:60%:nowrap' \
    )"
    cd "$(dirname "$file")" || return
}

cdfa(){
    # cd via fzf - cd into `fasd` 'frecency' dir, show preview of directory tree
    #
    # https://www.devdoc.net/web/developer.mozilla.org/en-US/docs/The_Places_frecency_algorithm.html
    #
    local dir
    #
    # --select-1 "auto select if only one match; do not start finder"
    dir="$(fasd -dl \
        | fzf \
            --tac \
            --reverse \
            --no-sort \
            --select-1 \
            --no-multi \
            --tiebreak=index \
            --query "$*" \
            --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
            --preview-window='right,40%:wrap' \
    )" || return
    cd "$dir" || return
}

viff(){
    # vi via fzf - from fzf list of files in `pwd`, open selected file in default editor (vim)
    #
    # also see similar aliases `vif`, `vifp`, `fzh`, `fzp`
    #
    local IFS=$'\n'
    local files=()
    local fzf_preview_cmd
    #
    fzf_preview_cmd='bat --color=always --theme=zenburn {}'
    #
    # --exit-0   "exit if no match for initial query"
    # --select-1 "auto select if only one match; do not start finder"
    files=(
        "$(fzf \
            --multi \
            --exit-0 \
            --select-1 \
            --query="$*" \
            --preview="${fzf_preview_cmd}" \
            --preview-window='right:60%:nowrap' \
        )"
    ) || return
    "${EDITOR:-vim}" "${files[@]}"
}

fco(){
    # checkout git branch/tag
    #
    local tags branches target
    #
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
    # shellcheck disable=SC2001,SC2046
    git checkout $(echo "$target" | awk '{print $2}')
}

fcoc(){
    # checkout git commit
    #
    local commits commit
    #
    commits=$(git log --pretty=oneline --abbrev-commit --reverse)
    # +s --no-sort
    # +m --no-multi
    # --tac "reverse order of input"
    commit=$(echo "$commits" | fzf --tac +s +m --exact)
    # shellcheck disable=SC2001,SC2046
    git checkout $(echo "$commit" | sed "s/ .*//")
}

fcor(){
    # checkout git branch (incl remote), sorted by most recent commit, limit n
    #
    local branches branch limit=50
    #
    branches=$(git for-each-ref \
               --count=$limit \
               --sort=-committerdate \
               refs/heads/ \
               --format="%(refname:short)")
    branch=$(echo "$branches" \
             | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m)
    # shellcheck disable=SC2001,SC2046
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fcs(){
    # checkout commit sha
    #
    local commits commit
    #
    commits=$(git log --color=always \
              --pretty=oneline --abbrev-commit --reverse)
    commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse)
    # shellcheck disable=SC2001,SC2046
    git checkout $(echo -n $(echo "$commit" | sed "s/ .*//"))
}

fshow(){
    # git commit browser
    #
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


#-
# switch tmux pane (@george-b)
#=-----------------------------------------------------------------------------
#`
ftpane(){
    local panes current_window current_pane target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_pane=$(tmux display-message -p '#I:#P')
    current_window=$(tmux display-message -p '#I')
    #
    target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return
    #
    target_window=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$1}')
    target_pane=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)
    #
    if [[ $current_window -eq $target_window ]]; then
        tmux select-pane -t "${target_window}.${target_pane}"
    else
        tmux select-pane -t "${target_window}.${target_pane}" &&
        tmux select-window -t "$target_window"
    fi
}


#-
# try to securely deal with passwords
#=-----------------------------------------------------------------------------
#`
readpass(){
    local was
    echo -n >&2 "Password: "
    was="$(stty -a | grep -ow -e '-\?echo')" pass
    stty -echo
    read -r pass
    stty "$was"
    echo >&2
    echo "$pass"
}

setpass(){
    local id="$1" group="$2" pw=""
    if [[ "$OS" == Darwin ]]; then
        pw=$(readpass)
        security delete-generic-password -a "$group" -s "$id" 2> /dev/null
        security add-generic-password -a "$group" -s "$id" -w "$pw"
    fi
}

getpass(){
    local id="$1" group="$2"
    if [[ "$OS" == Darwin ]]; then
        security find-generic-password -a "$group" -s "$id" -w
    fi
}


#-
# string helpers
#=-----------------------------------------------------------------------------
#`
lower(){
    cat | tr '[:upper:]' '[:lower:]'
}

upper(){
    cat | tr '[:lower:]' '[:upper:]'
}

capitalize(){
    cat | perl -ne 'print lc' | perl -ane 'print join " ", map {ucfirst} @F'
}


#-
# initialize fasd, without aliases
#=-----------------------------------------------------------------------------
#`
eval "$(fasd --init bash-hook bash-ccomp bash-ccomp-install)"


#-
# work setup
#=-----------------------------------------------------------------------------
#`
[ -f ~/.workrc ] && . ~/.workrc
