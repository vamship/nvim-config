return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		opts = {
			heading = {
				right_pad = 1,
				icons = { "☰" },
			},
			checkbox = {
				checked = { icon = "✔ " },
				custom = {
					custom = {
						raw = "[~]",
						rendered = "✘ ",
						highlight = "RenderMarkdownUnchecked",
						scope_highlight = "@markup.strikethrough",
					},
				},
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_theme = "light"
		end,
		event = "VeryLazy",
		keys = {
			{
				"<leader>bmp",
				"<CMD>MarkdownPreviewToggle<CR>",
				desc = "Toggle Markdown Preview",
			},
		},
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
	},
}
