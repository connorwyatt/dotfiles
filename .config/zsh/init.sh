source "$HOME/.config/zsh/oh-my-zsh.sh"

export EDITOR="nvim"

path+=("$HOME/.bin")
path+=("$HOME/.bin-local")

autoload -Uz compinit
compinit

SOURCES_FILES_STR=$(fd --glob '*.sh' $HOME/.config/zsh/sources)
SOURCES_FILES=($(echo $SOURCES_FILES_STR | tr '\n' ' '))

for FILE in $SOURCES_FILES; do
    source $FILE
done

mkdir -p $HOME/.config/zsh/sources-local

SOURCES_LOCAL_FILES_STR=$(fd --glob '*.sh' $HOME/.config/zsh/sources-local)
SOURCES_LOCAL_FILES=($(echo $SOURCES_LOCAL_FILES_STR | tr '\n' ' '))

for FILE in $SOURCES_LOCAL_FILES; do
    source $FILE
done
