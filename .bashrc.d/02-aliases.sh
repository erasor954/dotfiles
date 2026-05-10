# 02-aliases.sh: Shell Aliases

alias tma="tmux new-session -A -s main"
alias vi="nvim"
alias vim="nvim"
alias sdkl="sdk list java | rg 'local only'"
alias copy="wl-copy"
alias grep="rg"

alias ll="ls -l"
alias la="ls -la"

alias inv='nvim $(fzf -m --preview="bat -n --color=always {}")'
