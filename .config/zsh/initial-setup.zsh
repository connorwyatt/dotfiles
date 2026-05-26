if (( ${+commands[brew]} )); then
    local bundle_cache="$HOME/.config/zsh/.brew_bundle"
    local current_date=$(date +%Y%m%d)

    if [[ ! -f "$bundle_cache" ]] || [[ "$(cat "$bundle_cache")" != "$current_date" ]]; then
        brew bundle --file="$HOME/.config/zsh/Brewfile" --no-upgrade --quiet

        echo "$current_date" > "$bundle_cache"
    fi
fi
