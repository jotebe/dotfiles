#!/bin/zsh

function create_link() {
	[[ -e "$DOTFILES_PATH/$1" ]] || return
	echo -n "  ~/$2 : "
	if [[ ! -e "$HOME/$2" ]]; then
    mkdir -p "$(dirname "$HOME/$2")"
		ln -sv "$DOTFILES_PATH/$1" "$HOME/$2"
	else
		echo "already exists"
	fi
}

DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/.dotfiles"}
echo "Installing to $DOTFILES_PATH..."

create_link 'git/gitconfig' '.gitconfig'
create_link 'git/gitignore' '.gitignore'
create_link 'ruby/irbrc' '.irbrc'
create_link 'ruby/gemrc' '.gemrc'
create_link 'ruby/pryrc' '.pryrc'
create_link 'tmux/tmux.conf' '.tmux.conf'
create_link 'bin/safe-reattach-to-user-namespace' '.bin/safe-reattach-to-user-namespace'
create_link 'ackrc' '.ackrc'
create_link 'zsh/prezto' '.zprezto'

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]] || ln -sv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/backup
[ -e $HOME/.vim/bundle ] || ln -s $DOTFILES_PATH/vim/bundle $HOME/.vim/bundle

create_link 'vim/vimrc' '.vimrc'
