path+="$HOME/.cargo/bin"

if (( ${+commands[cargo]} )); then
    . "$HOME/.cargo/env"
fi
