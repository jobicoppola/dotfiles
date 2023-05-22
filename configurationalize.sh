#!/usr/bin/env bash
# get home dir sorted

[ -n "$1" ] && update=1 || update=0

cd "$(dirname $0)" || exit

RRED='\e[7;31m' # red
EC='\e[0m' # end color

warn(){
    local text="$1"
    [[ -z "$1" ]] && text=WARNING
    echo -e "${RRED} ${text} ${EC}"
}

echo -e "$(warn) This script can/will dropkick existing files in $HOME"
read -rp "Ok to proceed? (y/n) " yaynay

STAMP=$(date +"%Y%m%d-%H%M%S")
BACKUPDIR=~/tmp/$(basename $(pwd))-backup-$STAMP

if [[ $yaynay == y* ]]; then
    echo -e "\nSyncing dotfiles repo with home dir..."
    echo -e "\nBackup up existing files to $BACKUPDIR"
    rsync \
        --verbose \
        --keep-dirlinks \
        --exclude-from ".excludes/rsync" \
        --exclude-from ".excludes/rsync-$(uname)" \
        --backup --backup-dir $BACKUPDIR/ -av . ~

    echo -e "\nInstalling vundle bundles"
    vim +PluginInstall +qall

    if [ ${update} -eq 1 ]; then
        echo -e "\nUpdating vundle bundles"
        vim -c VundleUpdate -c quitall

        echo -e "\nTuning user prefs and conf files for OS friendliness"
        [[ $(uname) == Linux ]] && bin/tune-linux
        [[ $(uname) == Darwin ]] && bin/tune-osx
    fi
fi

. ~/.bashrc
