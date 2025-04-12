# configs
all the configs i'll ever need. 

it's easiest to set up via symlinks. i have just provided relative paths here, but symlinks tend to prefer absolute ones. just run the following set of commands.

to set up iterm2, first import the json profile. also under appearance>general set theme:minimal. we also setup oh-my-zsh. 
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-jetbrains-mono
ln -sf ./.zshrc ~/.zshrc
```

currently the following is my setup.
```shell
ln -sf ./latex ~/Library/texmf/tex/latex
ln -sf ./nvim ~/.config/nvim
ln -sf ./aerospace ~/.config/aerospace
```

previously i used yabai+skhd to manage windows. 
```shell
ln -sf ./skhd ~/.config/skhd
ln -sf ./yabai ~/.config/yabai
```
