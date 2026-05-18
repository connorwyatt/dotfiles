if (( ${+commands[zoxide]} )); then
    eval "$(zoxide init zsh)"

    export _ZO_FZF_OPTS=""
fi
