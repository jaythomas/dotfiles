# Shell aliases
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lA'
alias l='ls'
alias l.="ls -A | egrep '^\.'"
alias mirrors='sudo reflector --score 100 --fastest 25 --sort rate --save /etc/pacman.d/mirrorlist --verbose'
alias merge='xrdb -merge ~/.Xresources'
alias pacman='sudo pacman --color auto'
alias sshadd='eval "$(ssh-agent)" && ssh-add ~/.ssh/id_rsa'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yu='yaourt -Syu'
