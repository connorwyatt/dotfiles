if (( ${+commands[brew]} )); then
    brew bundle --file="$HOME/.config/zsh/Brewfile" --no-upgrade --quiet
fi
