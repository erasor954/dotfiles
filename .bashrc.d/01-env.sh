# 01-env.sh: Environment Variables

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export PS1="\u@\h:\w\$ "

# TeXLive
export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
export INFOPATH="/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH"
export MANPATH="/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
