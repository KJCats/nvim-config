# License
Do whatever you want with this config! Copy, modify, share - no restrictions.

# My Neovim Configuration

A mostly Plugin less config inspired by https://github.com/radleylewis/nvim-lite/tree/youtube_demo

## Features

- Telescope fuzzy finding
- Treesitter syntax highlighting
- Custom Keymaps

- Redirected the terminal, statusline and keymaps into lua/

## Installation
```bash
git clone https://github.com/KJCats/nvim-config.git ~/.config/nvim

```

But better just follow https://www.youtube.com/watch?v=skW3clVG5Fo&t=1619s

## Plugins

- telescope:
```lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            -- Deine gewünschten Mappings
            ["<C-u>"] = false,    -- Ctrl-U deaktivieren
            ["<C-d>"] = false,    -- Ctrl-D deaktivieren
          },
        },
        preview = {
          treesitter = true,
        },
      },
      pickers = {
        find_files = {
          hidden = true,  -- Versteckte Dateien anzeigen
        },
      },
    })

    -- Keymaps setzen
    local builtin = require("telescope.builtin")
    
    vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<C-f>g", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<C-f>b", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<C-f>h", builtin.help_tags, { desc = "Help tags" })
  end
}
```

- treesitter:
```lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query", 
        "python", "javascript", "bash",
        "html", "css", "json", "markdown"
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end
}
```

- undotree:
```lua
return {
  "mbbill/undotree",
  keys = {
    {
      "<leader>u",
      function()
        vim.cmd.UndotreeToggle()
        -- Optional: Focus auf Undotree fenster
        vim.cmd([[
          if &filetype == "undotree"
            wincmd p
          endif
        ]])
      end,
      desc = "Undotree toggle"
    },
  },
  config = function()
    -- Nur undotree-spezifische Einstellungen
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_HelpLine = 0
    
    -- Weitere nützliche Optionen:
    vim.g.undotree_TreeNodeShape = '◦'     -- Symbole für die Baumansicht
    vim.g.undotree_TreeSplitShape = '/'
    vim.g.undotree_TreeReturnShape = '\\'
  end
}
```
