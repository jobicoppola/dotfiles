#!/bin/bash
# get home dir sorted

cd "$(dirname $0)"

git pull

read -p "NOTE: This can/will dropkick existing files in $HOME - proceed? (y/n) " yaynay

if [[ $yaynay == y* ]]; then
    echo -e "\nSyncing dotfiles repo with home dir...\n"
    rsync --exclude ".git/" --exclude "README.md" --exclude "configurationalize.sh" --exclude ".DS_Store" -av . ~
fi

. "$HOME/.bashrc"
