# samir-roy/init.nvim

## A NeoVim Configuration

This is a NeoVim configuration written in Lua. It has a fair amount of comments
to help personalize and adapt it. It includes various common useful plugins
including TreeSitter, LSPZero, and Telescope.

It uses the [Shinjuku](https://github.com/samir-roy/shinjuku.nvim) color scheme
and includes various useful key mappings.

![screenshot](https://github.com/samir-roy/shinjuku.nvim/blob/main/screenshot.png)

## Installation

### Requirements

 * [NeoVim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
 * [ripgrep](https://github.com/BurntSushi/ripgrep#installation)

### Download

Clone this repo into the nvim config location:

```sh
# on Linux and Mac
git clone https://github.com/samir-roy/init.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```


```sh
# on Windows
git clone https://github.com/samir-roy/init.nvim.git %userprofile%\AppData\Local\nvim\ 
```

### Post Installation

Run the following command and then **you are ready to go**!

```sh
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

In case the above command fails, start `nvim` and then type `:PackerSync`.

