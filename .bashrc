# shellcheck shell=bash
#
#>=-</.|.\>=-------------------------------------------------------------------
#
# ~/.bashrc :: jcopp.cfxd.net
#
#=-----------------------------------------------------------------------------
#`

[ -z "$PS1" ] && return  # only proceed for interactive shells


#--
# configure shell
#=-----------------------------------------------------------------------------

# command history
#
HISTCONTROL=ignoreboth       # ignore duplicates and cmds starting with spaces
shopt -s histappend          # append to history
#
# try unlimited history
# https://superuser.com/questions/137438/how-to-unlimited-bash-shell-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_history_forever
#
# write history from current shell every prompt
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# case-insensitive tab-completion for paths
shopt -s nocaseglob

# lets us use ** to find files/dirs
shopt -s globstar

# hostname completion
HOSTFILE=~/.ssh/known_hosts
shopt -s hostcomplete


#--
# set some vars
#=-----------------------------------------------------------------------------

os=$(uname)  # determine os

# differentiate between intel macs and newer macs with apple silicon chips
# previously these dotfiles synced right into home dir, and for now we
# want to just let old macs keep doing it that way
#
silicon=false
arch="$(uname -m)"
[[ "$arch" == 'arm64' ]] && silicon=true

# path to where dotfiles repo is synced to (see `configurationalize.sh`)
# (let old macs keep syncing to home dir instead of ~/.config)
#
# TODO use `dotconf` var set in `.bashrc.skel` instead of $config
#
if [[ "$silicon" == 'true' ]]; then
    config=~/.config/$(whoami)/dotfiles
else
    config=$HOME
fi

# customize platform vars as needed
mac='' linux='' hostname='' user=''

# macos
if [[ "$os" == 'Darwin' ]]; then
    mac=true
    hostname=$(hostname |cut -d . -f 1)  # remove .lan or .local
    user="$(whoami)@$hostname"
fi

# linux
if [[ "$os" == 'linux' ]]; then
    linux=true
    hostname=$(hostname)
    user="$(whoami)@$hostname"
fi

# for using `rg` and `fd` instead of grep and find
fd=$(which fd) fd="${fd:-find}"
rg=$(which rg) rg="${rg:-grep}"

# also see corresponding exported vars after path is set
rbenv_bin=$HOME/.rbenv/bin       # rbenv
gem_bin=$HOME/gems/bin           # rubygems
node_bin=$HOME/node_modules/.bin # nodejs
cargo_bin=$HOME/.cargo/bin       # rust
go_bin=~/go/bin                  # go
go_env=~/go/env                  # go

# create go dirs if they don't exist
[ -d "$go_env" ] || mkdir -p "$go_env"

# kitten is not added to /opt/homebrew/bin; specify here and add to path below
kitty_bin=/Applications/kitty.app/Contents/MacOS


#--
# path setup
#=-----------------------------------------------------------------------------

if [[ "$mac" == true ]]; then
    #
    # try to make path vars easier to reorganize later if necessary
    #
    rbenvbin=$rbenv_bin
    gembin=$gem_bin
    nodebin=$node_bin
    gobin=$go_bin
    cargobin=$cargo_bin
    #
    homebrew=/opt/homebrew
    brewbin=$homebrew/bin
    brewsbin=$homebrew/sbin
    coreutilsbin=$homebrew/Cellar/coreutils/9.5/bin
    grepbin=$homebrew/Cellar/grep/3.11/bin
    javabin=$homebrew/opt/openjdk/bin
    #
    pybin=$HOME/Library/Python/3.12/bin
    fasdbin=$HOME/bin/fasd/bin
    dotfilesbin=$HOME/.config/$(whoami)/dotfiles/bin
    homebin=$HOME/bin
    #
    kittybin=$kitty_bin
    #
    systembins=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
    #
    prebin=$rbenvbin
    #
    path=$prebin:$brewbin:$brewsbin:$coreutilsbin:$grepbin:$javabin
    path+=:$gembin:$nodebin:$gobin:$cargobin
    path+=:$pybin:$fasdbin:$dotfilesbin:$homebin:$kittybin
    path+=:$systembins
    export PATH=$path
elif [[ "$linux" == true ]]; then
    path=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin
    path+=:$HOME/bin
    export PATH=$path
else
    echo "Failed to update path - not on mac or linux - reported OS is $os"
    export PATH=$PATH
fi


#--
# export some vars
#=-----------------------------------------------------------------------------

ARCHFLAGS="-arch x86_64"                            # make compilers behave; intel
[[ "$arch" == 'arm64' ]] && ARCHFLAGS="-arch $arch" # apple silicon
export ARCHFLAGS=$ARCHFLAGS

# set editor vars
vim=$(which vim)
export EDITOR="$vim"
export GIT_EDITOR="$vim"
export GIT_MERGE_AUTOEDIT=no

# use `bat` as manpage formatter
export MANROFFOPT="-c"
export MANPAGER="sh -c 'sed -r \"s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g\" | col -bx | bat -l man -p'"

# bat config file path
export BAT_CONFIG_PATH="$config/.batconfig"

# java needed for stackhawk cli
export JAVA_HOME=/opt/homebrew/opt/openjdk/bin

# ruby
export RUBYOPT=rubygems
export GEM_HOME=$HOME/gems  # also see $gem_bin
export RUBYPATH=$GEM_HOME
export GEM_PATH=$GEM_HOME

# node path
export NODE_PATH=/usr/local/lib/node_modules

# go dirs
export GOBIN="${go_bin}"
export GOENV="${go_env}"


#--
# ssh setup
#=-----------------------------------------------------------------------------

if [ -s "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
  rm -f "$SSH_AUTH_SOCK"
  SSH_AUTH_SOCK=/tmp/ssh-agent-$(hostname)
  export SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
  if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval ssh-agent -a "$SSH_AUTH_SOCK" -s
    ssh-add
  fi
fi


#--
# prompt setup
#=-----------------------------------------------------------------------------

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
    local cmsg tmsg smsg umsg gstat
    cmsg='nothing to commit'
    tmsg='Changes to be committed'
    smsg='Changes not staged for commit'
    umsg='nothing added to commit but untracked files present'
    gstat=$(git status 2> /dev/null) || return
    if [[ $(echo "$gstat" | grep -c "$smsg") -gt 0 ]]; then
        echo '?'
    elif [[ $(echo "$gstat" | grep -c "$tmsg") -gt 0 ]]; then
        echo '!'
    elif [[ $(echo "$gstat" | grep -c "$umsg") -gt 0 ]]; then
        echo 'u'
    elif [[ $(echo "$gstat" | grep -c "$cmsg") -gt 0 ]]; then
        echo '¬'
    else
        echo 'f'
    fi
}

# bring in named colors to customize prompt
[ -f "$config/.bash_colors" ] && . "$config/.bash_colors"

# bring in and customize kube_ps1 to display k8s info in prompt
kube_ps1_path=/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh
[ -f "$kube_ps1_path" ] && . "$kube_ps1_path"
export KUBE_PS1_PREFIX=''
export KUBE_PS1_SUFFIX=''
export KUBE_PS1_SYMBOL_COLOR=27
export KUBE_PS1_CTX_COLOR=39
export KUBE_PS1_NS_COLOR=81

# set color vars
ec="$EC"
clock_color="$COLOR_71"
pipe_color="$GRAY"
venv_color="$GREEN"
host_color="$BWHITE"
path_color="$BYELLOW"
user_color="$COLOR_132"
cwd_color="$COLOR_72"
branch_color="$COLOR_173"
status_color="$COLOR_149"
dollar_color="$COLOR_244" # force gray to override any theme

# prompt vars
ps1_kube="\n\$(kube_ps1)${pipe_color}"
ps1_time="\n${clock_color}\t${pipe_color}"
ps1_venv="${venv_color}\$(get_venv)"
ps1_user="\u@\h${host_color}\w${path_color}" # linux
ps1_user_mac="${ec}${user_color}${user}" # mac
ps1_cwd="${cwd_color}\w" # original, \W returns only basename of cwd
ps1_git="${branch_color}\$(get_git_branch_current_for_prompt)"
ps1_git+="${status_color}\$(get_git_status)${ec}"
ps1_end="\n${ec}${GRAY}$ ${ec}" # linux
ps1_end_mac="\n${dollar_color}$ ${ec}" # mac

# set ps1_kube to empty string if not in aws-vault session
[ -z "$AWS_VAULT" ] && ps1_kube=""

# now actually set the prompt
if [[ "$mac" == 'true' ]]; then
    # macos
    PS1="${ps1_kube}${ps1_time}|${ps1_venv}${ps1_user_mac}${ps1_cwd}${ps1_git}${ps1_end_mac}"
else
    # linux
    PS1="${ps1_time}$GRAY|${ps1_venv}${ps1_user}${ps1_git}${ps1_end}"
fi


#--
# source aliases, completions and other custom config files TODO
#=-----------------------------------------------------------------------------

[ -f ~/.alias ] && . ~/.alias
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# http status codes
[ -f "$config/.http-status-codes" ] && . "$config/.http-status-codes"

# mac specific
if [[ "$mac" == true ]]; then
    [ -f "$config/.bash_aliases_osx" ] && . "$config/.bash_aliases_osx"

    # homebrew bash completions
    #
    # completion files are in:
    # /opt/homebrew/etc/bash_completion.d/*
    #
    # NOTE: may need to run `brew completions link` after the below
    #
    brew_prefix=$(brew --prefix)
    brew_conf=${brew_prefix}/etc
    brew_bash_completions_dir=${brew_conf}/bash_completion.d
    #
    brew_bash_profile_completions=${brew_conf}/profile.d/bash_completion.sh
    grc_completions=${brew_conf}/grc.sh
    git_completions=${brew_bash_completions_dir}/git-completion.bash
    #
    # export var to fix completions for brew itself not working
    # see https://github.com/orgs/Homebrew/discussions/4227
    #
    homebrew_repo="$(brew --prefix)"
    export HOMEBREW_REPOSITORY="$homebrew_repo"
    #
    [ -r "$brew_bash_profile_completions" ] && . "$brew_bash_profile_completions"
    [ -f "$grc_completions" ] && GRC_ALIASES=true . "$grc_completions"
    [ -f "$git_completions" ] && . "$git_completions"

    # awscli completions
    [ -f "$(which aws_completer)" ] && complete -C "$(which aws_completer)" aws

    # fzf installer, writes completions to home dir
    "${brew_prefix}/opt/fzf/install" --key-bindings --completion --no-update-rc >/dev/null 2>&1
    [ -f ~/.fzf.bash ] && . ~/.fzf.bash

    # make completions work for kubectl when invoked via alias `k`
    complete -F __start_kubectl k

    # helm chart releaser
    . <(cr completion bash)
fi


#--
# rg and fzf commands
#=-----------------------------------------------------------------------------

rg_command='rg --column --line-number --no-heading --fixed-strings '
rg_command+='--ignore-case --no-ignore --hidden --color "always" --glob "!.git"'
rg_command_dirs='rg --no-heading --ignore-case --no-ignore --hidden --color "always"'

# set default - also used by vim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --no-follow --glob "!.git"'


#--
# rg, fzf, fasd functions - some custom, some from fzf wiki examples
#=-----------------------------------------------------------------------------

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

fcb(){
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


#--
# switch tmux pane (@george-b)
#=-----------------------------------------------------------------------------

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


#--
# try to securely deal with passwords
#=-----------------------------------------------------------------------------

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
    if [[ "$os" == Darwin ]]; then
        pw=$(readpass)
        security delete-generic-password -a "$group" -s "$id" 2> /dev/null
        security add-generic-password -a "$group" -s "$id" -w "$pw"
    fi
}

getpass(){
    local id="$1" group="$2"
    if [[ "$os" == Darwin ]]; then
        security find-generic-password -a "$group" -s "$id" -w
    fi
}


#--
# string helpers
#=-----------------------------------------------------------------------------

lower(){
    cat | tr '[:upper:]' '[:lower:]'
}

upper(){
    cat | tr '[:lower:]' '[:upper:]'
}

capitalize(){
    cat | perl -ne 'print lc' | perl -ane 'print join " ", map {ucfirst} @F'
}

trim(){
    cat | perl -ne 's/^\s+|\s+$//g; print $_'
}


#--
# bring in shared functions
#=-----------------------------------------------------------------------------

[ -f "$config/share/functions.tmp" ] && . "$config/share/functions.tmp"


#--
# initialize rbenv and fasd without aliases
#=-----------------------------------------------------------------------------

eval "$(rbenv init -)"
eval "$(fasd --init bash-hook bash-ccomp bash-ccomp-install)"


#--
# source work setup
#=-----------------------------------------------------------------------------

[ -f "$config/.workrc" ] && . "$config/.workrc"
