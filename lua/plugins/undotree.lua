return {
	"mbbill/undotree",
	keys = {
		{
			"<leader>u",
			function()
				vim.cmd.UndotreeToggle()
				vim.cmd([[
          if &filetype == "undotree"
            wincmd p
          endif
        ]])
			end,
			desc = "Undotree toggle",
		},
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_DiffAutoOpen = 1
		vim.g.undotree_DiffpanelHeight = 10
		vim.g.undotree_HelpLine = 0
		vim.g.undotree_TreeNodeShape = "◦"
		vim.g.undotree_TreeSplitShape = "/"
		vim.g.undotree_TreeReturnShape = "\\"
	end,
}
