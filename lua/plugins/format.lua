return {
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
			python = { "ruff" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			rust = { "rustfmt" },
			html = { "prettierd" },
			css = { "prettierd" },
			markdown = { "prettierd" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
			bash = { "shfmt" },
		},
	},
}
