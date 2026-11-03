# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export AUTHOR="Shaleen Baral"

ZSH_THEME="awesomepanda"
plugins=(
  vi-mode
  zsh-autosuggestions
  git
)

source "$ZSH/oh-my-zsh.sh"

# Show the directory instead of username@hostname in window/tab titles.
ZSH_THEME_TERM_TITLE_IDLE='%~'
ZSH_THEME_TERM_TAB_TITLE_IDLE='%~'

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# BEGIN opam configuration
if [[ -r "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1
fi
# END opam configuration

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/shaleenbaral/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# Python
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"

  if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# CS3410
alias rv='docker run -i --init -e NETID=sb969 --rm -v "$PWD":/root --name cs3410 ghcr.io/sampsyo/cs3410-infra'
alias rv-debug='docker run -it --rm --init -e NETID=sb969 --name testing --ulimit core=-1 --mount type=bind,source="$PWD"/,target="$PWD"/ -v "$PWD":/root ghcr.io/sampsyo/cs3410-infra'

# CS4411
alias eos='docker run -it -v "${PWD}:/embryos" --rm embryos'

# TeXpresso and MacTeX; keep PATH entries unique.
typeset -U PATH path
path=(
  "$HOME/Documents/texpresso/build/TeXpresso.app/Contents/MacOS"
  # /Library/TeX/texbin
  "${path[@]}"
)
export PATH


# Let TeXpresso discover the index of personal LaTeX packages.
export TEXMFDBS="$HOME/Library/texmf:${TEXMFDBS:-}"
