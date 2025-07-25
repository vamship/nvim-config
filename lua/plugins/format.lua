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
			python = { "yapf" },
			javascript = { "prettier" },
			rust = { "rustfmt" },
			html = { "prettier" },
            markdown = { "prettier" },
		},
	},
}
