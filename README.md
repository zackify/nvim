# Setup

- install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install [vim plug](https://github.com/junegunn/vim-plug)
- add [ripgrep](https://github.com/BurntSushi/ripgrep)
- setup [denite requirements](https://github.com/Shougo/denite.nvim#requirements)
- add [powerline fonts](https://github.com/powerline/fonts)
- add [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
- add [git gutter](https://github.com/airblade/vim-gitgutter)
- add to zshrc:

```
alias vi="nvim"
alias sudo="sudo "
```

- add solarized dark

```
git clone git@github.com:altercation/vim-colors-solarized.git
mkdir ~/.config/nvim/colors/
mv vim-colors-solarized/colors/solarized.vim ~/.config/nvim/colors/
```
