if brew list --formula | grep -q "^nvm$"; then
    export NVM_DIR="$HOME/.nvm"
    local nvm_prefix="$(brew --prefix nvm)"
    [ -s "$nvm_prefix/nvm.sh" ] && \. "$nvm_prefix/nvm.sh"
    [ -s "$nvm_prefix/etc/bash_completion.d/nvm" ] && \. "$nvm_prefix/etc/bash_completion.d/nvm"
fi
