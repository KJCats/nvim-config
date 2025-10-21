# License
Do whatever you want with this config! Copy, modify, share - no restrictions.

# My Neovim Configuration

A custom config inspired by https://github.com/radleylewis/nvim-lite/tree/youtube_demo
While the video focuses on a clean and plugin-less configuration,
I added some (ca. 9) Plugins to improve it for my needs.

## Features

- Telescope fuzzy finding
- Treesitter syntax highlighting
- Undotree for Undo History
- Custom statusline
- Floating terminal
- lsp and completion support
- English dictionary
- Word definitions with the `dict` command.
- Markdown highlighting
- Better Rust support
- Customizable colorscheme
- Custom Keymaps

- Redirected the terminal, statusline and keymaps into lua/
- All plugins are in lua/plugins
- The colorscheme is located in colors/
- The dictionary is located in dictionary/ and needs to be a .txt unfortunately


## Installation
```bash
git clone https://github.com/KJCats/nvim-config.git ~/.config/nvim

```

For a detailed video of the original setup, see here: https://www.youtube.com/watch?v=skW3clVG5Fo&t=1619s
Also remember to back-up your old settings just in case.

## Plugins

- telescope:

[telescope.lua](./lua/plugins/telescope.lua)

- treesitter:

[treesitter.lua](./lua/plugins/treesitter.lua)

- undotree:

[undotree.lua](./lua/plugins/undotree.lua)

- nvim-cmp:

[completions.lua](./lua/plugins/completions.lua)

- mason/lspconfig:

[lsp.lua](./lua/plugins/lsp.lua)

- render-markdown:

[markdown.lua](./lua/plugins/markdown.lua)

- mini-icons(needed for render-markdown):

[mini-icons.lua](./lua/plugins/mini-icons.lua)

- rust-tools:

[rust-tools.lua](./lua/plugins/rust-tools.lua)

## Keymaps

### Vim Keymaps

`mapleader` = " "
`maplocalleader` = " "

Most important:

`<leader>e`: open nvim's file explorer.\n
`<leader>ff`: find files in current directory.\n 
`<leader>rc`: open configs.\n
`<leader>t`: open floating terminal.\n

Here for more:
[keymaps.lua](./lua/keymaps.lua)

### Plugin Keymaps:

`<C-CR>`: confirm completion.\n
`K`: show code definition.\n
`<leader>k`: show word definition.\n
`<leader>vd`: View diagnostics.\n
`<leader>ca`: Code actions.\n
`<leader>rr`: rename symbol through file.\n
`<leader>u`: toggle undotree.\n
`<C-f>`: fuzzyfind files in current directory.\n
`<C-f>g`: live grep in current directory.\n
`<C-f>b`: find buffers.\n
`<C-f>h`: help tags.
