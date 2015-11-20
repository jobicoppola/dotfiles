#!/bin/bash
# get home dir sorted

cd "$(dirname $0)"

git pull
git submodule --quiet update --init

read -p "NOTE: This can/will dropkick existing files in $HOME - proceed? (y/n) " yaynay

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
    vim +BundleInstall +qall

    echo -e "\nTuning user prefs and conf files for OS friendliness"
    [[ "$(uname)" == Linux ]] && bin/tune-linux || bin/tune-osx
fi

. ~/.bashrc
