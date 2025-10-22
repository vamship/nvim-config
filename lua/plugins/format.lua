return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format()
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
				javascript = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				rust = { "rustfmt" },
				html = { "prettierd" },
				css = { "prettierd" },
				markdown = { "prettierd" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				bash = { "shfmt" },
			},
		},
	},
}
