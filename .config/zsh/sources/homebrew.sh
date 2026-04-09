if (( ${+commands[brew]} )); then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    UPDATE_CACHE="$HOME/.config/zsh/.brew_last_check"
    current_date=$(date +%Y%m%d)

    if [[ ! -f "$UPDATE_CACHE" ]] || [[ "$(cat "$UPDATE_CACHE")" != "$current_date" ]]; then
        echo ""
        echo -n "Checking for Homebrew updates..."

        data=$(brew outdated --json=v2)

        formulae_list=$(echo "$data" | jq -r '[.formulae[].name] | join(", ")')
        casks_list=$(echo "$data" | jq -r '[.casks[].name] | join(", ")')

        if [[ -n "$formulae_list" || -n "$casks_list" ]]; then
            echo -e "\r\e[KOutdated Homebrew packages:"
            [[ -n "$formulae_list" ]] && echo -e "  \e[33m•\e[0m Formulae: $formulae_list"
            [[ -n "$casks_list" ]] && echo -e "  \e[33m•\e[0m Casks: $casks_list"
        else
            echo -e "\r\e[K\e[32m✔\e[0m All Homebrew packages are up to date!"
        fi

        echo "$current_date" > "$UPDATE_CACHE"
    fi
fi
