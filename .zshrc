# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export AUTHOR="Shaleen Baral"

ZSH_THEME="awesomepanda"

plugins=(
  zsh-autosuggestions
  git
  )

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
