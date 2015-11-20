#!/bin/bash
# vim: set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4:
set -e -u

if [[ ${DOTFILES_PATH:-unset} == 'unset' ]]; then
	export DOTFILES_PATH="$HOME/.dotfiles"
fi

if [[ -d ${DOTFILES_PATH}/.git ]]; then
	cd "${DOTFILES_PATH}"
	git fetch
	git merge --ff-only origin/master
else
	git clone https://github.com/rtlong/dotfiles.git "${DOTFILES_PATH}"
	cd "${DOTFILES_PATH}"
fi


git submodule update --init --recursive

echo -e "\n[ link.sh ]\n"
./link.sh

echo -e "\n[ setup.sh ]\n"
./setup.sh
