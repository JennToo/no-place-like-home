#!/bin/bash

rm -f "dotfiles/config/nvim/plugin-snapshot.vim"
nvim -c ":PlugSnapshot dotfiles/config/nvim/plugin-snapshot.vim" -c ":qa"
sed -i -e 's/".*//g'  dotfiles/config/nvim/plugin-snapshot.vim
