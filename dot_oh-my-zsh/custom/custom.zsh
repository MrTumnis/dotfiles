(( ${+aliases[man]} )) && unalias man
man() {
    if [[ -z "$1" ]]; then
        return 1
    fi
    local cmd="$1"
    local answer
    read "answer?Would you like to use tldr instead? y/n: "
    if [[ "$answer" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
        command tldr "$cmd"
    else
        command man "$cmd"
    fi
}
