tmux-directory() {
    if [[ ! -d $1 ]]; then
        echo "Directory ($1) does not exist"
        return
    fi
    tmux new -A -c $1 -s $(basename "$1" | tr . _)
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
alias tpwd='tmux new -A -s $(basename "$PWD" | tr . _)'
alias ts='tmux-sessionizer'
