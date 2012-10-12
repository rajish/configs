#!/bin/bash

CFGDIR="$( cd -P "$( dirname "$0" )" && pwd )"

CONFIGS=("$HOME/.emacs" "$HOME/.emacs.d" "$HOME/.bashrc" "$HOME/.bash_profile")

for file in "${CONFIGS[@]}"; do

    if [ -L "$file" ]; then
        rm "$file"                     # this is link so we can safely remove it
    elif [ -e "$file" ]; then
        read -p "The file '$file' exists and is not a symbolic link. Do you want to remove it? [y/N] " -n 1 ANS
        echo
        [ "$ANS" == 'y' -o "$ANS" == 'Y' ] &&
        rm -rf "$file"
    fi &&
    ln -s "$CFGDIR/$(basename $file)" "$file"
done
