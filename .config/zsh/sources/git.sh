if (( ${+commands[git]} )); then
    local current_script_path=${0:a}
    local gitconfig_last_hash="$HOME/.config/zsh/.gitconfig_last_hash"
    local current_script_hash=$(cat "$current_script_path" | sha256)

    if [[ ! -f "$gitconfig_last_hash" ]] || [[ "$(cat "$gitconfig_last_hash")" != "$current_script_hash" ]]; then
        git config --global core.editor nvim
        git config --global push.autoSetupRemote true
        git config --global init.defaultBranch main
        git config --global commit.verbose true
        git config --global diff.tool nvimdiff
        git config --global difftool.prompt false
        git config --global difftool.nvimdiff.cmd 'nvim -d $BASE $LOCAL $REMOTE $MERGED -c '\''$wincmd w'\'' -c '\''wincmd J'\'
        git config --global merge.tool nvimdiff
        git config --global mergetool.prompt false
        git config --global mergetool.nvimdiff.cmd 'nvim -d $BASE $LOCAL $REMOTE $MERGED -c '\''$wincmd w'\'' -c '\''wincmd J'\'
        git config --global alias.clone-for-worktrees '!sh $HOME/.bin/git-clone-bare-for-worktrees'
        git config --global diff.algorithm minimal

        echo "$current_script_hash" > "$gitconfig_last_hash"
    fi

    git-worktree-add-remote() {
        git worktree add "$1" "origin/$1"
    }

    dotfiles-worktree-add-remote() {
        dotfiles worktree add "$1" "origin/$1"
    }

    alias dg='dotfiles'
    alias dgai='dotfiles add --interactive'
    alias dgam='dotfiles am'
    alias dgap='dotfiles add --patch'
    alias dgau='dotfiles add --all --intent-to-add'
    alias dgc='dotfiles commit'
    alias dgca='dotfiles commit --amend'
    alias dgcp='dotfiles commit --patch'
    alias dgd='dotfiles diff'
    alias dgdp='dotfiles diff --patch --raw'
    alias dgdw='dotfiles diff --word-diff'
    alias dgf='dotfiles fetch --all'
    alias dgfp='dotfiles fetch --all --prune'
    alias dgl='dotfiles log'
    alias dglg="dotfiles log --graph --pretty='%C(magenta)%h%Creset%C(auto)%d%Creset %s %C(yellow)(%ad) %C(bold cyan)<%an>%Creset' --date=short"
    alias dgls='dotfiles log --stat'
    alias dglsp='dotfiles log --stat --patch'
    alias dgm='dotfiles merge'
    alias dgmtl='dotfiles mergetool --no-prompt'
    alias dgp='dotfiles push'
    alias dgpra='dotfiles pull --rebase --autostash'
    alias dgrb='dotfiles rebase'
    alias dgrs='dotfiles restore'
    alias dgrsp='dotfiles restore --patch'
    alias dgst='dotfiles status'
    alias dgsw='dotfiles switch'
    alias dgswc='dotfiles switch -c'
    alias dgwa='dotfiles worktree add'
    alias dgwar='dotfiles-worktree-add-remote'
    alias dgwl='dotfiles worktree list'
    alias dgwr='dotfiles worktree remove'
    alias g='git'
    alias gai='git add --interactive'
    alias gam='git am'
    alias gap='git add --patch'
    alias gau='git add --all --intent-to-add'
    alias gc='git commit'
    alias gca='git commit --amend'
    alias gcp='git commit --patch'
    alias gd='git diff'
    alias gdp='git diff --patch --raw'
    alias gdw='git diff --word-diff'
    alias gf='git fetch --all'
    alias gfp='git fetch --all --prune'
    alias gl='git log'
    alias glg="git log --graph --pretty='%C(magenta)%h%Creset%C(auto)%d%Creset %s %C(yellow)(%ad) %C(bold cyan)<%an>%Creset' --date=short"
    alias gls='git log --stat'
    alias glsp='git log --stat --patch'
    alias gm='git merge'
    alias gmtl='git mergetool --no-prompt'
    alias gp='git push'
    alias gpra='git pull --rebase --autostash'
    alias grb='git rebase'
    alias grs='git restore'
    alias grsp='git restore --patch'
    alias gst='git status'
    alias gsw='git switch'
    alias gswc='git switch -c'
    alias gwa='git worktree add'
    alias gwar='git-worktree-add-remote'
    alias gwl='git worktree list'
    alias gwr='git worktree remove'
fi
