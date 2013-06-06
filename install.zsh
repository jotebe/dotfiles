#!/bin/zsh

DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/.dotfiles"}
[[ -e "$HOME/.gitconfig" ]] || ln -s "$DOTFILES_PATH/git/gitconfig" "$HOME/.gitconfig"
