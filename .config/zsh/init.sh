source "$HOME/.config/zsh/oh-my-zsh.sh"

export EDITOR="nvim"

path+=("$HOME/.bin")

autoload -Uz compinit
compinit

FILES_STR=$(fd --glob '*.sh' ~/.config/zsh/sources)
FILES=($(echo $FILES_STR | tr '\n' ' '))

for FILE in $FILES; do
    source $FILE
done
