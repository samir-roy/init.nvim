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

When you first open Neovim, Lazy.nvim plugin manager will automatically install,
followed by all the configured plugins.

Alternatively, you can run:
```sh
nvim --headless "+Lazy! sync" +qa
```


## Keymaps

The leader key is `<space>` since the space bar is easy to reach.

### File Picker
- `<C-p>` - picker (files in git repository)
- `<leader>p` - picker (files in git repository)
- `<leader>x` - xplorer (toggle file explorer using nvim-tree)
- `<leader>t` - tabs (list of open buffers)

### Buffer Navigation
- `<leader>fc` - close current buffer
- `<leader>l` - jump to last accessed buffer
- `<leader>1-9` - jump to nth buffer
- `<leader>[` - previous buffer
- `<leader>]` - next buffer

### Movement
- `<leader>b` - jump to line start (same as $)
- `<leader>e` - jump to line end (same as ^)
- `<leader>m` - jump to matching bracket (same as %)
- `<leader>j/k` - page down/up (centered)
- `[[` and `]]` - jump to prev/next in jump list
- `]c` and `[c` - jump to prev/next hunk (git change)

### Insert Mode
- `jj` - easier escape out of insert mode
- `<C-h>` - cursor movement left
- `<C-j>` - cursor movement down
- `<C-k>` - cursor movement up
- `<C-l>` - cursor movement right

### Normal mode
- `?` - clear search highlighting
- `<leader>n` - search for current word while keeping cursor in place
- `<leader>r` - search and replace current word
- `<leader>u` - show / hide undo tree
- `<leader>w` - save all buffers (same as :wa)
- `<leader>W` - save current buffer (same as :w)

### Visual Mode
- `L` - easily move selected lines down
- `H` - easily move selected lines up

### Normal or Visual Mode
- `<leader>P` - paste without replacing clipboard
- `<leader>y` - yank to system clipboard
- `<leader>Y` - yank to system clipboard (line)
- `<leader>/` - comment / uncomment current line or selection

### Language Server
- `<leader>i` - info (show hover info)
- `<leader>a` - actions (list available code actions)
- `<leader>g` - go to definition (same as gd)
- `<leader>d` - diagnostics (open float)
- `<leader>.` - format file using lsp

### Find Files (using telescope)
- `<leader>fp` - find files in project folder
- `<leader>fw` - find word under the cursor
- `<leader>ff` - find in files using grep
- `<leader>fk` - kontinue find (reopen results)
- `<leader>fd` - files having diagnostics
- `<leader>fr` - recently opened files

### Search and Replace in Files (using spectre)
- `<leader>ss` - search and replace
- `<leader>S` - search and replace in split screen
- `<leader>sw` - search for word under the cursor
- `<leader>sw` (visual) - search for text in selection
