if (( ${+commands[brew]} )); then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_NO_AUTO_UPDATE=1

    local update_cache="$HOME/.config/zsh/.brew_last_check"
    local current_week=$(date +%Y%V)

    if [[ ! -f "$update_cache" ]] || [[ "$(cat "$update_cache")" != "$current_week" ]]; then
        brew update-if-needed

        data=$(brew outdated --json=v2)

        formulae_list=$(echo "$data" | jq -r '[.formulae[].name] | join(", ")')
        casks_list=$(echo "$data" | jq -r '[.casks[].name] | join(", ")')

        if [[ -n "$formulae_list" || -n "$casks_list" ]]; then
            echo -e "Outdated Homebrew packages:"
            [[ -n "$formulae_list" ]] && echo -e "  \e[33m•\e[0m Formulae: $formulae_list"
            [[ -n "$casks_list" ]] && echo -e "  \e[33m•\e[0m Casks: $casks_list"
        fi

        echo "$current_week" > "$update_cache"
    fi
fi
