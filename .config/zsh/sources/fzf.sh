export FZF_DEFAULT_OPTS_FILE="$HOME/.config/zsh/fzf-default-opts"
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source <(fzf --zsh)
