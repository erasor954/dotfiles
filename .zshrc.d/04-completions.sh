if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit

zstyle ':completion:*:*:(vim|nvim|vi|nano|emacs|cat|less):*' ignored-patterns '*.(class|o|pyc|zwc)' '.DS_Store'
