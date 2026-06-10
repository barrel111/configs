# configs
all the configs i'll ever need. 

it's easiest to set up via symlinks. i have just provided relative paths here, but symlinks tend to prefer absolute ones. just run the following set of commands.

install dependencies:
```bash
./scripts/install.sh  # see scripts/Brewfile for full dep list
```

set up oh-my-zsh and symlink zshrc:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf "$(pwd)/.zshrc" ~/.zshrc
```

install the MacTeX distribution manually. set up iterm2 by importing the json profile; under appearance>general set theme:minimal.

currently the following is my setup. requires that the corresponding folders don't already exist.
```shell
ln -sf "$(pwd)/aerospace" ~/.config/aerospace
ln -sf "$(pwd)/latex" ~/Library/texmf/tex/latex
ln -sf "$(pwd)/nvim" ~/.config/nvim
mkdir -p ~/Library/Application\ Support/typst/packages/local
ln -sf "$(pwd)/typst" ~/Library/Application\ Support/typst/packages/local
ln -sf "$(pwd)/ghostty" ~/Library/Application\ Support/com.mitchellh.ghostty
```

previously i used yabai+skhd to manage windows. 
```shell
ln -sf "$(pwd)/skhd" ~/.config/skhd
ln -sf "$(pwd)/yabai" ~/.config/yabai
```

currently don't use skhd,yabai or iterm2.
