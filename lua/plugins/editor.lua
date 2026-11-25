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
		-- Stand-in for native multicursor (Neovim 0.13); keys mirror the native ones
		-- so this spec can be removed after upgrading.
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local map = vim.keymap.set
			map("n", "Q", function()
				if vim.v.count > 0 then
					mc.searchAllAddCursors()
				else
					mc.toggleCursor()
				end
			end, { desc = "Toggle cursor; [count]Q adds cursors at all search matches" })
			map("x", "Q", mc.visualToCursors, { desc = "Place a cursor on each selected line" })
			map({ "n", "x" }, "<c-leftmouse>", mc.handleMouse, { desc = "Toggle cursor" })
			map({ "n", "x" }, "q=", function()
				if mc.cursorsEnabled() then
					mc.disableCursors()
				else
					mc.enableCursors()
				end
			end, { desc = "Toggle cursor follow mode" })
			map({ "n", "x" }, "]C", function()
				for _ = 1, vim.v.count1 do
					mc.nextCursor()
				end
			end, { desc = "Jump to next cursor" })
			map({ "n", "x" }, "[C", function()
				for _ = 1, vim.v.count1 do
					mc.prevCursor()
				end
			end, { desc = "Jump to previous cursor" })
			map({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "Insert ascending numbers at cursors" })
			map("n", "gQ", mc.restoreCursors, { desc = "Restore cleared cursors" })

			-- Only active while multiple cursors exist, so <C-l> still switches tabs otherwise.
			mc.addKeymapLayer(function(layerSet)
				layerSet({ "n", "x" }, "<c-l>", function()
					if mc.cursorsEnabled() then
						mc.clearCursors()
					end
				end, { desc = "Clear cursors" })
				layerSet({ "n", "x" }, "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)
		end,
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
}
