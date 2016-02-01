#!/bin/bash
# vim: set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4:
set -e -u

[[ ${DOTFILES_PATH:-} ]] || export DOTFILES_PATH="$HOME/.dotfiles"

cd "${DOTFILES_PATH}"

# git submodule update --init --recursive

echo -e "\n[ link.sh ]\n"
./link.sh

echo -e "\n[ setup.sh ]\n"
./setup.sh
