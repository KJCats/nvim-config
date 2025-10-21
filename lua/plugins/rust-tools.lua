return {
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						-- Rust Keybinds
						local opts = { buffer = bufnr }
						vim.keymap.set("n", "K", rt.hover_actions.hover_actions, opts)
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, opts)
						vim.keymap.set("n", "<Leader>r", rt.runnables.runnables, opts)
					end,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = true,
							check = {
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							cargo = {
								loadOutDirsFromCheck = true,
							},
							procMacro = {
								enable = true,
							},
						},
					},
				},
				tools = {
					hover_actions = {
						auto_focus = true,
					},
					runnables = {
						use_telescope = true,
					},
				},
			})
		end,
	},
}
