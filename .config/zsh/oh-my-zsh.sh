ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"

if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

export ZSH="$HOME/.oh-my-zsh"

zstyle ":omz:update" mode auto

plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
