#!/bin/zsh

DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/.dotfiles"}
echo "Installing to $DOTFILES_PATH..."

function create_link() {
	[[ -e "$DOTFILES_PATH/$1" ]] || return
	echo -n "  ~/$2 : "
	if [[ ! -e "$HOME/$2" ]]; then
		ln -sv "$DOTFILES_PATH/$1" "$HOME/$2"
	else
		echo "already exists"
	fi
}

create_link 'git/gitconfig' '.gitconfig'
create_link 'git/gitignore' '.gitignore'

create_link 'ruby/irbrc' '.irbrc'
create_link 'ruby/gemrc' '.gemrc'
create_link 'ruby/pryrc' '.pryrc'
create_link 'ruby/powconfig' '.powconfig'

create_link 'tmux/tmux.conf' '.tmux.conf'

create_link 'ackrc' '.ackrc'

create_link 'zsh/prezto' '.zprezto'
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]] || ln -sv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

create_link 'vim/vimrc' '.vimrc'
if [[ ! -e "$HOME/.vim/bundle/vundle" ]]; then
	git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle && \
		vim +BundleInstall +qall
fi
