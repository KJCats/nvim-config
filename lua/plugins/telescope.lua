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
						["<C-u>"] = false, -- Disable Ctrl-U
						["<C-d>"] = false, -- Disable Ctrl-D
					},
				},
				preview = {
					treesitter = true,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<C-f>g", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<C-f>b", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<C-f>h", builtin.help_tags, { desc = "Help tags" })
	end,
}
