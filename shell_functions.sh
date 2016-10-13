function can_exec {
	command -v $1 2>&1 >/dev/null
}

alias ll='ls -laF'
alias dotfiles='cd ${DOTFILES_PATH}'
alias gopath='cd $(go env GOPATH)'
alias goroot='cd $(go env GOROOT)'
alias goproj='gopath; cd src/github.com/rtlong/'
alias reload-zshrc='source ~/.zshrc'
alias ssh-coreos-forward-ports='ssh -L 8182:localhost:8182 -L 2379:localhost:2379 -l core -o "IdentitiesOnly no"'
can_exec hub \
		&& alias git='hub'
can_exec pygmentize \
		&& alias ccat='pygmentize -g -O style=colorful,linenos=1'
can_exec docker-compose \
		&& alias dc=docker-compose


if can_exec caffeinate; then
	# prevent OSX system sleep during active SSH connections
	function ssh {
		caffeinate -i ssh "$@"
	}
fi

if can_exec bundle; then
	function cd-to-gem-source {
		cd `bundle show $1`
	}
fi

function dotfiles-update {
	(
		cd "${DOTFILES_PATH}"
		git fetch --recurse-submodules=on-demand
		git stash
		git merge --ff-only
		git submodule update --init
		git stash pop
		./install.sh
	)
}

if can_exec slackline; then
	function status-update {
		slackline -c '#status' $@
	}
fi

function source-env {
	[[ -f env.sh ]] && source env.sh
}

function set-window-title {
	[[ $TMUX ]] || return
	local title="${1:-$(basename "$PWD")}"
	command tmux rename-window "$title"
}
alias swt='set-window-title'

function set-pane-title {
	[[ $TMUX ]] || return
	local title="${1:-$(basename "$PWD")}"
	printf '\033]2;%s\033\\' "$title"
}
alias spt='set-pane-title'

if [[ $TMUX ]]; then
	function ssh-fix-auth-sock {
		[[ -r $SSH_AUTH_SOCK ]] && return
		eval $(tmux show-environment SSH_AUTH_SOCK | grep SSH_AUTH_SOCK=)
		[[ -r $SSH_AUTH_SOCK ]] && export SSH_AUTH_SOCK
	}
fi

function set-iterm-tab-title {
	printf '\033]0;%s\007' "$1"
}

function list-all-code-projects {
	echo "$DOTFILES_PATH"
	find "${CODE_WORKSPACE_ROOT}" -maxdepth 6 -name .git -print | sed 's:/.git::'
}
function choose-code-project {
	if ! can_exec pick; then
		echo "FATAL: Can't find 'pick' command" >&2
		return 1
	fi
	list-all-code-projects | pick
}

function cdp {
	cd "$(choose-code-project)"
	set-window-title
	set-pane-title
}

function bridgefog-mode {
	tmux-named-session bridgefog "${CODE_WORKSPACE_BRIDGEFOG:-$CODE_WORKSPACE_ROOT}"
}

function gg-mode {
	tmux-named-session GG "${CODE_WORKSPACE_GOODGUIDE:-$CODE_WORKSPACE_ROOT}"
}

function tmux-named-session {
	emulate -L zsh
	set -u
	local name="$1"; shift
	local dir="$1"; shift
	TMUX='' tmux new-session -d -s "$name" -c "$dir" #2>/dev/null
	if [[ ${TMUX:-} ]]; then
		command tmux switch-client -t "$name"
	else
		command tmux attach -t "$name"
	fi
}

function newd {
	mkdir -p "$1" && cd "$1" && set-window-title
}

function node_depcheck {
	ack '(?:import .+ from |require\()['"'"'"]([a-zA-Z][^/]+).*['"'"'"]\)?' --nogroup -h --output '$1' \
		^node_modules/ *.js \
		| sort | uniq >! /tmp/deps_used
	jq -r '.dependencies + .devDependencies | keys | .[]' < package.json \
		| sort >! /tmp/deps_defined
	command comm -1 -3 /tmp/deps_{used,defined}
}

function docker-inspect {
	docker inspect "$1" | jq -r ".[0] ${2:+| $2}"
}

function json-preview-url {
	curl -fsSL "$1" | jq -C . | less -R
}

function json_pp {
	jq -C . | less -R
}

if ! can_exec dot; then
	function dot {
		docker run --rm -i quay.io/goodguide/graphviz:alpine-3.2-0 dot "$@"
	}
fi

if ! can_exec tred; then
	function tred {
		docker run --rm -i quay.io/goodguide/graphviz:alpine-3.2-0 tred "$@"
	}
fi

if [[ -f ~/.local/lib/jenkins-cli.jar ]]; then
	function jenkins {
		args=()
		if [[ ${JENKINS_PRIV_KEY} ]]; then
			args+=( -i ${JENKINS_PRIV_KEY} )
		fi
		java -jar ~/.local/lib/jenkins-cli.jar "${args[@]}" "$@"
	}
fi

function env {
	command env | cat -v | sort
}

NVM_DIR="${NVM_DIR:-"$HOME/.nvm"}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
	export NVM_DIR
	function load-nvm {
		printf "Loading NVM..."
		source "$NVM_DIR/nvm.sh"
		# printf "done!\n"
	}
else
	unset NVM_DIR
fi

function inspect-args() {
	local i=0
	for arg in "$@"; do
		let i+=1
		printf 'ARG[%d] = "%s"\n' $i "$arg"
	done
}

function edit() {
	eval "$EDITOR '$1'"
}

function edit-tramp() {
	eval "$EDITOR '/ssh:${TRAMP_HOSTNAME}:$PWD/$1'"
}

function cdtfroot() {
	d="$(tfjump)"
	if [[ $? -eq 0 ]]; then
			cd "$d"
	fi
}
