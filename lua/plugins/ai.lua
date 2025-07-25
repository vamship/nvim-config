return {
	"github/copilot.vim",
	{
		"yetone/avante.nvim",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				dependencies = {
					-- make sure rendering happens even without opening a markdown file first
					"yetone/avante.nvim",
				},
				opts = function(_, opts)
					opts.file_types = opts.file_types or { "markdown", "norg", "rmd", "org" }
					vim.list_extend(opts.file_types, { "Avante" })
				end,
			},
		},
		build = ":AvanteBuild",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ax",
				"<ESC>:AvanteClear<CR>",
				"Clear the Avante chat windowt",
			},
			{
				"<leader>a+",
				function()
					local tree_ext = require("avante.extensions.nvim_tree")
					tree_ext.add_file()
				end,
				desc = "Select file in NvimTree",
				ft = "NvimTree",
			},
			{
				"<leader>a-",
				function()
					local tree_ext = require("avante.extensions.nvim_tree")
					tree_ext.remove_file()
				end,
				desc = "Deselect file in NvimTree",
				ft = "NvimTree",
			},
		},
		opts = {
			provider = "copilot",
			hints = { enabled = false },
			mappings = {
				sidebar = {
					switch_windows = "<C-Tab>",
					reverse_switch_windows = "<C-S-Tab>",
				},
				submit = {
					insert = "<C-Enter>",
				},
			},
			windows = {
				input = {
					height = 10,
				},
			},
			-- system_prompt as function ensures LLM always has latest MCP server state
			-- This is evaluated for every message, even in existing chats
			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				return hub and hub:get_active_servers_prompt() or ""
			end,
			-- Using function prevents requiring mcphub before it's loaded
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
		},
	},
}
