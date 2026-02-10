return {
	"tpope/vim-surround",
	"tpope/vim-abolish",
	"tpope/vim-repeat",
	"machakann/vim-highlightedyank",
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"M",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle flash search",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"3rd/image.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ii",
				function()
					local image = require("image")
					if image.is_enabled() then
						image.disable()
					else
						image.enable()
					end
				end,
				desc = "Toggle image rendering",
			},
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				config = function()
					require("nvim-treesitter.configs").setup({
						ensure_installed = { "markdown" },
						highlight = { enable = true },
					})
				end,
			},
		},
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					only_render_image_at_cursor_mode = "inline",
					filetypes = { "markdown" }, -- markdown extensions (ie. quarto) can go here
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = nil,
			kitty_method = "normal",
		},
	},
}
