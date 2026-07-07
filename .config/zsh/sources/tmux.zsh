tmux-attach() {
    if [[ -z $TMUX ]]; then
        tmux attach -t $1
        exit 0
    fi

    tmux switch-client -t $1
}

tmux-create-or-attach() {
    local dir=${~1}

    if [[ ! -d $dir ]]; then
        echo "Directory ($1) does not exist"
        return
    fi

    session_name="${${2:-${1}}//./_}"

    if [[ -z $TMUX ]]; then
        tmux new-session -A -s $session_name -c $dir
        return
    fi

    tmux new-session -ds $session_name -c $dir

    tmux switch-client -t $session_name
}

alias ta='tmux-attacher'
alias tls='tmux ls'
alias tnl='tmux-nvim-layout'
alias tnlc='tmux-nvim-layout-cursor'
alias tpwd='tmux-create-or-attach $PWD'
alias ts='tmux-sessionizer'
