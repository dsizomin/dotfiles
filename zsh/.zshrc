ZSH_DISABLE_COMPFIX="true"

source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle zsh-users/zsh-history-substring-search

antigen bundle mafredri/zsh-async

antigen theme sindresorhus/pure@main

antigen apply

eval $(thefuck --alias)
