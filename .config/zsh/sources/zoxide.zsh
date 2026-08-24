if (( ${+commands[zoxide]} )); then
    eval "$(zoxide init zsh --cmd cd)"

    export _ZO_FZF_OPTS=""

    zoxide-workspace() {
        printf "\033]2;zoxide-workspace\a"
        local selected=$(fzf-workspace)
        [[ -z $selected ]] && return
        cd ${~selected}
    }

    alias cdw='zoxide-workspace'
fi
