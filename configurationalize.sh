#!/bin/bash
# get home dir sorted

cd "$(dirname $0)"

git pull

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
    if [[ "$(uname)" == Linux ]]; then
        echo -e "\nTuning conf files for linux friendliness"
        bin/fix-os-diffs
    fi
fi

. ~/.bashrc
