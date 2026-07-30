# 02-aliases.sh: Shell Aliases

alias tma="tmux new-session -A -s main"
alias vi="nvim"
alias vim="nvim"
alias sdkl="sdk list java | rg 'local only'"
alias copy="pbcopy"
alias grep="rg"

alias dev="cd ~/Developer"

# alias ll="ls -l"
# alias la="ls -la"
alias ls="eza --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias la="eza -la --icons --group-directories-first"
alias lt="eza --tree --icons"

alias inv='nvim $(fzf -m --preview="bat -n --color=always {}")'

alias serve="deno run --allow-net --allow-read --watch jsr:@std/http/file-server --port=3000"
