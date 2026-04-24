if (( ${+commands[brew]} )); then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_NO_AUTO_UPDATE=1

    local update_cache="$HOME/.config/zsh/.brew_last_check"
    local current_date=$(date +%Y%m%d)

    if [[ ! -f "$update_cache" ]] || [[ "$(cat "$update_cache")" != "$current_date" ]]; then
        brew update

        echo "\nChecking for Homebrew updates..."

        data=$(brew outdated --json=v2)

        formulae_list=$(echo "$data" | jq -r '[.formulae[].name] | join(", ")')
        casks_list=$(echo "$data" | jq -r '[.casks[].name] | join(", ")')

        if [[ -n "$formulae_list" || -n "$casks_list" ]]; then
            echo -e "\e[KOutdated Homebrew packages:"
            [[ -n "$formulae_list" ]] && echo -e "  \e[33m•\e[0m Formulae: $formulae_list"
            [[ -n "$casks_list" ]] && echo -e "  \e[33m•\e[0m Casks: $casks_list"
        else
            echo -e "\e[K\e[32m✔\e[0m All Homebrew packages are up to date!"
        fi

        echo "$current_date" > "$update_cache"
    fi
fi
