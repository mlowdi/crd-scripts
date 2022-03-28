#!/usr/bin/bash

mv $HOME/.bashrc $HOME/.bashrc.bak
cp ./bashrc $HOME/.bashrc

if [ -e $HOME/.bash_aliases ]; then
    mv $HOME/.bash_aliases $HOME/.bash_aliases.bak
fi
cp ./bash_aliases $HOME/.bash_aliases
