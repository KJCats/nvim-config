return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").setup(opts)
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",

			{
				"uga-rosa/cmp-dictionary",
				opts = {
					paths = { vim.fn.expand("~/.config/nvim/dictionary/en.txt") },
					exact_length = 2,
					async = true,
					filetype = { "markdown", "text" },
				},
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "dictionary", keyword_length = 2 },
					{ name = "buffer" },
					{ name = "path" },
				}),

				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", vim_item.kind, entry.source.name)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
			})
		end,
	},
}
