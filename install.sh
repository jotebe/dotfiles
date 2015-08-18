#!/bin/bash
# vim: set noexpandtab tabstop=4 shiftwidth=0:
set -e -u

if [[ ${DOTFILES_PATH:-unset} == 'unset' ]]; then
	export DOTFILES_PATH="$HOME/.dotfiles"
fi

if [[ ! -d ${DOTFILES_PATH}/.git ]]; then
	if [[ -d ${DOTFILES_PATH} ]]; then
		echo "$DOTFILES_PATH already exists but isn't a git repo. Unsure how to continue."
		exit 1
	fi

	git clone https://github.com/rtlong/dotfiles.git "${DOTFILES_PATH}"
fi

cd "${DOTFILES_PATH}"

git submodule update --init --recursive

echo -e "\n[ link.sh ]\n"
./link.sh

echo -e "\n[ setup.sh ]\n"
./setup.sh
