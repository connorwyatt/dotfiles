fzf-workspace() {
    local base_directory="$HOME/Code"
    local shared_config="$HOME/.config/zsh/sources/resources/workspaces.json"
    local local_config="$HOME/.config/zsh/sources-local/resources/workspaces.json"

    local config_paths=(
        ${(f)"$(jq -r '.[]' "$shared_config")"}
        ${(f)"$([[ -f $local_config ]] && jq -r '.[]' "$local_config")"}
        ${(f)"$(fd '^.git$' $base_directory --hidden --exec bash -c 'cd {//}; git worktree list --porcelain' bash | \
            grep '^worktree ' | \
            grep -v '/.bare$' | \
            sd '^worktree ' '' | \
            sd "$HOME" '~')"}
    )

    config_paths=(${(ou)config_paths})

    print -rl -- $config_paths | fzf
}
