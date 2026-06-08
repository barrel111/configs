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
ln -sf ./.zshrc ~/.zshrc
```

install the MacTeX distribution manually. set up iterm2 by importing the json profile; under appearance>general set theme:minimal.

currently the following is my setup.
```shell
ln -sf ./aerospace ~/.config/aerospace
ln -sf ./latex ~/Library/texmf/tex/latex
ln -sf ./nvim ~/.config/nvim
mkdir -p ~/Library/Application\ Support/typst/packages/local
ln -sf ./typst "~/Library/Application Support/typst/packages/local"
```

previously i used yabai+skhd to manage windows. 
```shell
ln -sf ./skhd ~/.config/skhd
ln -sf ./yabai ~/.config/yabai
```
