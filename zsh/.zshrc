# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX="true"

source ~/antigen.zsh

source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.sh

source ~/.p10k.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle zsh-users/zsh-history-substring-search

# antigen bundle thefuck

# antigen bundle mafredri/zsh-async

antigen theme romkatv/powerlevel10k

antigen apply

# alias cls='colorls'

