source "$HOME/.config/zsh/oh-my-zsh.zsh"

export EDITOR="nvim"

path+=("$HOME/.bin")

mkdir -p "$HOME/.bin-local"
path+=("$HOME/.bin-local")

mkdir -p "$HOME/.local/bin"
path+=("$HOME/.local/bin")

autoload -Uz compinit
compinit

source $HOME/.config/zsh/initial-setup.zsh

SOURCES_FILES_STR=$(fd --glob '*.zsh' $HOME/.config/zsh/sources)
SOURCES_FILES=($(echo $SOURCES_FILES_STR | tr '\n' ' '))

for FILE in $SOURCES_FILES; do
    source $FILE
done

mkdir -p $HOME/.config/zsh/sources-local

SOURCES_LOCAL_FILES_STR=$(fd --glob '*.zsh' $HOME/.config/zsh/sources-local)
SOURCES_LOCAL_FILES=($(echo $SOURCES_LOCAL_FILES_STR | tr '\n' ' '))

for FILE in $SOURCES_LOCAL_FILES; do
    source $FILE
done
