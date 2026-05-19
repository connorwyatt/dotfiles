tmux-attach() {
    if [[ -z $TMUX ]]; then
        tmux attach -t $1
        exit 0
    fi

    tmux switch-client -t $1
}

tmux-create-or-attach() {
    session_name=$(echo "${2:-$1}" | tr . _)

    if [[ -z $TMUX ]]; then
        tmux new-session -A -s $session_name -c $1
        return
    fi

    tmux new-session -ds $session_name -c $1

    tmux switch-client -t $session_name
}

tmux-directory() {
    if [[ ! -d $1 ]]; then
        echo "Directory ($1) does not exist"
        return
    fi
    tmux-create-or-attach $1
}

alias ta='tmux-attacher'
alias tbin='tmux-directory ~/.bin'
alias tbinlocal='tmux-directory ~/.bin-local'
alias tconfig='tmux-directory ~/.config'
alias tdir='tmux-directory'
alias tls='tmux ls'
alias tnl='tmux-nvim-layout'
alias tnlc='tmux-nvim-layout-cursor'
alias tnvim='tmux-directory ~/.config/nvim'
alias tpwd='tmux-create-or-attach $PWD'
alias ts='tmux-sessionizer'
