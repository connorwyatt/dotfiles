zellij-create-or-attach() {
    local dir=${~1}

    if [[ ! -d $dir ]]; then
        echo "Directory ($1) does not exist"
        return
    fi

    raw_session_name=${2:-$1};
    session_name=${${raw_session_name:t}//[^[:alnum:]-_.]/_};

    zellij attach -c $session_name options --default-cwd $dir
}

alias za="zellij-attacher"
alias zs="zellij-sessionizer"
