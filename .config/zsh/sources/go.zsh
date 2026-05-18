if (( ${+commands[go]} )); then
    path+="$(go env GOPATH)/bin"
fi
