autoload -Uz compinit
compinit

zstyle ':completion:*:*:(vim|nvim|vi|nano|emacs|cat|less):*' ignored-patterns '*.(class|o|pyc|zwc)' '.DS_Store'
