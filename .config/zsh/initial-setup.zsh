if (( ${+commands[brew]} )); then
    local bundle_cache="$HOME/.config/zsh/.brew_bundle"
    local current_week=$(date +%Y%V)

    if [[ ! -f "$bundle_cache" ]] || [[ "$(cat "$bundle_cache")" != "$current_week" ]]; then
        brew bundle --file="$HOME/.config/zsh/Brewfile" --no-upgrade --quiet

        echo "$current_week" > "$bundle_cache"
    fi
fi
