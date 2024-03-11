alias dot="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias vi="nvim"
alias vim="nvim"

PS1="[%~] "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
