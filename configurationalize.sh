#!/usr/bin/env bash
# get home dir sorted

[ -n "$1" ] && update=1 || update=0

cd "$(dirname $0)"

emoji="\xE2\x9D\x97"

echo -e "$emoji WARNING: This script can/will dropkick existing files in $HOME"
read -rp "Ok to proceed? (y/n) " yaynay

STAMP=$(date +"%Y%m%d-%H%M%S")
BACKUPDIR=~/tmp/$(basename $(pwd))-backup-$STAMP

if [[ $yaynay == y* ]]; then
    echo -e "\nSyncing dotfiles repo with home dir..."
    echo -e "\nBackup up existing files to $BACKUPDIR"
    rsync --exclude ".git*" \
        --exclude "README.md" \
        --exclude "configurationalize.sh" \
        --exclude ".DS_Store" \
        --exclude "macbot.itermcolors" \
        --keep-dirlinks \
        --backup --backup-dir $BACKUPDIR/ -av . ~

    echo -e "\nInstalling vundle bundles"
    vim +PluginInstall +qall

    if [ ${update} -eq 1 ]; then
        echo -e "\nUpdating vundle bundles"
        vim -c VundleUpdate -c quitall
    fi

    ln -sf ~/.bash_aliases_user ~/.bash_aliases_$(whoami)

    echo -e "\nTuning user prefs and conf files for OS friendliness"
    if [[ $(uname) == Linux ]]; then
        bin/tune-linux
        rm -f ~/.bash_aliases_osx
    elif [[ $(uname) == Darwin ]]; then
        bin/tune-osx
        rm -f ~/.bash_aliases_{el,linux,ubuntu}
    fi
fi

. ~/.bashrc
