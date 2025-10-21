return {
	-- Mason (LSP/Debugger/Formatter/Linter Manager)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSP
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "html", "cssls", "ltex" },
				handlers = {
					["clangd"] = function() end,
				},
			})
		end,
	},

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Define a standard on_attach function to apply to all servers.
			-- This is where you set keymaps for LSP features.
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to Definition
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Hover documentation
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts) -- View Workspace Symbols
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts) -- View Diagnostics
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts) -- Go to next diagnostic
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code Action
				vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts) -- Rename symbol
			end

			-- A list of servers to set up with the standard on_attach and capabilities
			local servers = { "lua_ls", "html", "cssls" }

			for _, server_name in ipairs(servers) do
				lspconfig[server_name].setup({ -- THIS IS THE NEW, CORRECT SYNTAX
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- Setup for servers that need special, custom settings
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					},
				},
			})

			lspconfig.ltex.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					ltex = {
						language = "en-US",
						disabledRules = {
							["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
						},
					},
				},
				filetypes = { "markdown", "tex", "gitcommit" },
			})

			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--fallback-style={BasedOnStyle:LLVM,ReferenceAlignment:Left,PointerAlignment:Left}",
				},
			})
		end,
	},

	--Formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				cpp = { "lsp" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
