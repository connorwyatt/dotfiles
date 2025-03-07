ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"

if [[ ":$FPATH:" != *":/Users/connorwyatt/.zsh/completions:"* ]]; then export FPATH="/Users/connorwyatt/.zsh/completions:$FPATH"; fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="connor"

zstyle ":omz:update" mode auto

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
