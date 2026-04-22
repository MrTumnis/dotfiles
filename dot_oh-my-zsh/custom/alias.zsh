#navigation
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lsa='lsd -la'
alias cp='cp -v'
alias mv='mv -iv'
# alias diff='riff'
alias grep='grep --color=auto'
# alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias cl='clear'

alias loger='journalctl -p 3 -xb'
alias logf='journalctl -f'
alias logv='journalctl --verify'


#quick access 
alias ff='fastfetch'
alias vim='nvim'
alias vi='nvim'
alias nvm="NVIM_APPNAME=nvim-12 nvim"

alias cha='chezmoi add'
alias chd='chezmoi cd'

#power off
alias po="qs -c noctalia-shell ipc call sessionMenu toggle"
alias ro="qs -c noctalia-shell ipc call sessionMenu toggle"
alias ron="sudo reboot now"
alias lo="qs -c noctalia-shell ipc call sessionMenu lockAndSuspend"

#kitty 
# alias ssh='kitty +kitten ssh'
alias rg="rg --hyperlink-format=kitty"
alias ki='kitten icat'


#pacman 
alias pq='pacman -Slq | fzf --multi --preview "pacman -Si {}" | xargs -ro sudo pacman -S'
alias pi='sudo pacman -Qs'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias clean='sudo pacman -Sc'
alias tupdate='sudo pacman -Syu --print-format %n'

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -- "$tmp"
}



