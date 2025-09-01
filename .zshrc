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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/shaleenbaral/.opam/opam-init/init.zsh' ]] || source '/Users/shaleenbaral/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/shaleenbaral/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# <<< CS3410 <<<
alias rv='docker run -i --init -e NETID=sb969 --rm -v "$PWD":/root --name cs3410 ghcr.io/sampsyo/cs3410-infra'
