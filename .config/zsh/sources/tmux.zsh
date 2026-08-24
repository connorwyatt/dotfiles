tmux-attach() {
    if [[ -z $TMUX ]]; then
        tmux attach -t $1
        return
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

tmux-workspace() {
    printf "\033]2;tmux-workspace\a"
    local selected=$(fzf-workspace)
    [[ -z $selected ]] && return
    tmux-create-or-attach $selected
}

tmux-attacher() {
    printf "\033]2;tmux-attacher\a"
    local sessions=(${(f)"$(tmux ls -F '#{session_name}')"})
    local selected=$(print -rl -- $sessions | fzf)
    [[ -z $selected ]] && return
    tmux-attach $selected
}

alias ta='tmux-attacher'
alias tls='tmux ls'
alias tnl='tmux-nvim-layout'
alias tnlc='tmux-nvim-layout-cursor'
alias tpwd='tmux-create-or-attach $PWD'
alias tw='tmux-workspace'
