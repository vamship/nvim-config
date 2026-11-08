return {
	{
		"coder/claudecode.nvim",
        enabled = true,
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
		lazy = false,
		config = function()
			-- Option+l: accept the next word of the suggestion (<Tab> still accepts all)
			vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-word)", { desc = "Copilot accept word" })
			-- Option+j / Option+k: cycle through suggestions
			vim.keymap.set("i", "<M-j>", "<Plug>(copilot-next)", { desc = "Copilot next suggestion" })
			vim.keymap.set("i", "<M-k>", "<Plug>(copilot-previous)", { desc = "Copilot previous suggestion" })
			-- Option+h: "undo" a partial accept by deleting the previous word;
			-- Copilot then re-offers the remainder as a suggestion
			vim.keymap.set("i", "<M-h>", "<C-w>", { desc = "Delete previous word (undo partial accept)" })
		end,
		keys = {
			{ "<leader>ape", "<cmd>Copilot enable<cr>", desc = "Enable Copilot" },
			{ "<leader>apd", "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
			{ "<leader>aps", "<cmd>Copilot status<cr>", desc = "Copilot status" },
			{
				"<leader>app",
				function()
					-- Close the panel if it's open in this tab, otherwise open it
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype:match("^copilotpanel") then
							vim.api.nvim_win_close(win, true)
							return
						end
					end
					vim.cmd("Copilot panel")
				end,
				desc = "Toggle Copilot panel",
			},
		},
	},
}
