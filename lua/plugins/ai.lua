return {
	{
		"coder/claudecode.nvim",
        -- Note: If enabled, keybidings might conflict with avante.nvim
        enabled = false,
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
			},
			-- Diff management
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
	{
		"github/copilot.vim",
	},
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
