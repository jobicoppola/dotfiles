#!/usr/bin/env bash
#
#<<|>>=<<|>>=------------------------------------------------------------------
#`
#  configurationalize.sh :: jcopp.cfxd.net
#.
#|>=---------------------------------------------------------------------------
#`

#
# functions
#=-----------------------------------------------------------------------------
#

output(){
    local msg prefix
    msg="$1"
    prefix="==>"
    #
    printf "\n%s %s\n\n" "$prefix" "$msg"
}

warn(){
    local msg red endcolor
    msg="WARNING "
    red='\e[7;31m' # red
    endcolor='\e[0m' # end color
    #
    printf "\n%s %s\n\n%s" "$red" "$msg" "$endcolor"
}

sync_home(){
    local msg
    msg="Syncing specific files directly into home dir"
    #
    output "$msg"
    #
    # TODO refactor sync functionality
    #
    files_to_sync=(
        .bash_aliases
        .bash_profile
        .gitignore-global
        .jira.d
        .shellcheckrc
        .tmux.conf
        .vim
        .vimrc
    )

    # macos files to sync
    if [[ $(uname) == Darwin ]]; then
        files_to_sync+=(
            .tmux-osx.conf
        )
    fi

    # print list of files that will sync directly to home dir
    [[ "$DEBUG" ]] && printf "%s\n\n" "${files_to_sync[*]}"

    # kitty syncs separately
    # rsync does not accept file list when quoted
    # shellcheck disable=SC2048,2086
    rsync -av --exclude=kitty* ${files_to_sync[*]} ~/
}

sync_kitty(){
    # kitty has its own config dir so sync ./kitty dir to it
    local msg
    msg="Syncing kitty/ into ~/.config/kitty/"
    #
    output "$msg"
    rsync -av kitty/ ~/.config/kitty/
}

yaynay(){
    local msg
    msg="$(warn)This script will update existing files in $target_dir\n"
    #
    echo -e "$msg"
    read -rp "Ok to proceed? (y/n) " yaynay
    [[ "$yaynay" =~ n ]] && { echo "You have chosen not to proceed."; exit 2; }
}

checkdirs(){
    for d in "$backup_dir" "$target_dir" "$bin_dir"; do
        if [ -d "$d" ]; then
            [[ "$DEBUG" ]] && echo "$d exists"
        else
            [[ "$DEBUG" ]] && echo "Creating directory: $d"
            mkdir -p "$d"
        fi
    done
}

backup_current(){
    # note: this function only backs up modified files, not entire dir
    #
    # TODO remove old excludes
    # no longer needed since we now sync into ~/.config instead of ~/
    #
    # there are some files that need to go directly into home dir though,
    # see the `sync_home` function for that
    #
    #--exclude-from ".excludes/rsync" \
    #--exclude-from ".excludes/rsync-$(uname)" \
    #
    local msg
    msg="Backing up modified files and syncing updates into ~/.config"
    #
    if [[ $yaynay == y* ]]; then
        #
        [[ "$DEBUG" ]] && printf "\n%s\n%s\n" "$backup_dir" "$target_dir"
        output "$msg"
        #
        # note that .gitignore-global gets synced later
        rsync \
            --backup \
            --backup-dir "$backup_dir"/ \
            --exclude=.git* \
            --keep-dirlinks \
            --verbose \
            --archive \
            . "$target_dir"/
    fi
}

vim_plug_install(){
    local msg
    msg="Installing vim plugins"
    #
    [[ "$DEBUG" ]] && output "$msg"
    vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"
}

vim_plug_update(){
    local msg
    msg="Updating vim plugins"
    #
    output "$msg"
    vim -c "PlugUpdate" -c "qa"
}

os_tune(){
    local msg
    msg="Tuning user prefs and conf files for OS friendliness"
    #
    output "$msg"
    [[ $(uname) == Linux ]] && bin/tune-linux
    [[ $(uname) == Darwin ]] && bin/tune-osx
}

main(){
    yaynay
    checkdirs
    backup_current
    vim_plug_install
    sync_home
    sync_kitty

    [ "$update" -eq 1 ] && vim_plug_update
    [ "$update" -eq 2 ] && os_tune

    if [ "$update" -eq 3 ]; then
        vim_plug_update
        os_tune
    fi
}


#
# business cat
#=-----------------------------------------------------------------------------
#

# sanity check
#
cd "$(dirname "$0")" || { echo "Ruh roh! Can't find self"; exit 1; }

# set some vars
#
timestamp=$(date +"%Y%m%d-%H%M%S")
backup_dir=~/tmp/backups/dotfiles/$(basename "$(pwd)")-backup-$timestamp
target_dir=~/.config/"$(whoami)"/dotfiles
bin_dir=~/bin
yaynay=''
update=0

# optional update
#
case "$1" in
    -u|up*)      update=1    ;;  # update vim plugins
    -t|tune|os)  update=2    ;;  # update os preferences
    -a|all)      update=3    ;;  # update vim and os prefs
esac

# get to work
#
main
