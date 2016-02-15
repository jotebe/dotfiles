#!/bin/bash
# vim: set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4:
set -e -u

function echo_red() {
	echo -e "\x1b[31m$1\x1b[0m"
}

function echo_green() {
	echo -e "\x1b[32m$1\x1b[0m"
}

files_are_identical() {
	local md5=$(command -v md5 || command -v md5sum)
	local hash_1=$(cat $1 | $md5)
	local hash_2=$(cat $2 | $md5)
	[[ $hash_1 == $hash_2 ]]
}

function create_link() {
	local target="$DOTFILES_PATH/$1"; shift
	local destination="$1"; shift
	
	if [[ ! $destination =~ '^[~/]' ]]; then
		destination="$HOME/$destination"
	fi
	
	echo -n "  $destination : "
	[[ -e "$target" ]] || (echo_red "ERROR: Source does not exist"; exit 1)

	if [[ -h "$destination" ]]; then
		local current="$(readlink "$destination")"
		if [[ $current = $target ]]; then
			echo_green "already exists correctly"
		elif [[ ${CLOBBER:-unset} != unset ]]; then
			rm -fv "$destination"
			create_link "$1" "$2"
		else
			if [[ -r $current ]]; then
				echo_red "already exists as a symlink but does not point to $target"
			else
				echo_red "already exists as a broken symlink"
			fi
		fi
	elif [[ -e "$destination" ]]; then
		if [[ ${CLOBBER:-unset} != unset ]]; then
			rm -fv "$destination"
			create_link "$1" "$2"
		else
			echo_red "already exists"
		fi
	else
		mkdir -p "$(dirname "$destination")"
		ln -sv "$target" "$destination"
	fi
}

copy_if_missing(){
	echo -n "  ~/$2 : "
	[[ -e "$DOTFILES_PATH/$1" ]] || (echo_red "ERROR: Source does not exist"; exit 1)
	local destination="$HOME/$2"
	local target="$DOTFILES_PATH/$1"
	if [[ -h "$destination" ]]; then
		local current="$(readlink "$destination")"
		if [[ $current = $target ]]; then
			echo_green "already exists as a symlink"
		else
			if [[ -r $current ]]; then
				echo_red "already exists as a symlink but does not point to $target"
			else
				echo_red "already exists as a broken symlink"
			fi
		fi
	elif [[ -f "$destination" ]]; then
		if files_are_identical "$destination" "$target"; then
			echo_green "file aready exists but its content matches the source"
		else
			echo_red "skipping; already exists"
		fi
	elif [[ -e "$destination" ]]; then
		echo_red "skipping; already exists"
	else
		mkdir -p "$(dirname "$destination")"
		cp -v "$target" "$destination"
	fi
}

: ${DOTFILES_PATH:="${HOME}/.dotfiles"}

echo -e "Installing to $HOME from ${DOTFILES_PATH}...\n"

create_link 'git/gitconfig' '.gitconfig'
create_link 'git/gitignore' '.gitignore'

create_link 'ruby/irbrc' '.irbrc'
create_link 'ruby/gemrc' '.gemrc'
create_link 'ruby/pryrc' '.pryrc'

create_link 'ackrc' '.ackrc'
create_link 'agignore' '.agignore'
create_link 'ctags' '.ctags'
create_link 'dir_colors' '.dir_colors'
copy_if_missing 'htoprc' '.htoprc'
create_link 'tmux/tmux.conf' '.tmux.conf'

create_link 'zsh/prezto/' '.zprezto'
create_link 'zsh/zlogin' '.zlogin'
create_link 'zsh/zlogout' '.zlogout'
create_link 'zsh/zpreztorc' '.zpreztorc'
create_link 'zsh/zprofile' '.zprofile'
create_link 'zsh/zshenv' '.zshenv'
create_link 'zsh/zshrc' '.zshrc'

create_link 'bash/bashrc' '.bashrc'
create_link 'bash/bash_profile' '.bash_profile'

create_link 'osx_default_key_binding.dict' '~/Library/KeyBindings/DefaultKeyBinding.dict'

create_link 'emacs.d' '.emacs.d'

create_link 'vim/bundle' '.vim/bundle'
create_link 'vim/autoload' '.vim/autoload'
create_link 'vim/spell' '.vim/spell'
create_link 'vim/vimrc' '.vimrc'
mkdir -vp "$HOME/.vim/backup"

for bin in bin/*; do
	create_link "$bin" ".local/${bin}"
done

copy_if_missing 'ssh/config' '.ssh/config'
copy_if_missing 'ssh/known_hosts' '.ssh/known_hosts'

create_link 'vimperator/info' '.vimperator/info'
create_link 'vimperator/vimperatorrc' '.vimperatorrc'
