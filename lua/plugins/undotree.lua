-- Datei: lua/plugins/undotree.lua
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
