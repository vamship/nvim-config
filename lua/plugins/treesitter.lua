return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							["l="] = { query = "@assignment.lhs", desc = "Select lhs of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select rhs of an assignment" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of an argument" },
							["ia"] = { query = "@parameter.outer", desc = "Select inner part of an argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
							["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

							["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
							["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },

							["am"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
							["im"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>cna"] = { query = "@parameter.inner", desc = "Swap with next argument" },
							["<leader>cnf"] = { query = "@function.outer", desc = "Swap with next function" },
							["<leader>cns"] = { query = "@statement.outer", desc = "Swap with next statement" },
						},
						swap_previous = {
							["<leader>cpa"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
							["<leader>cpf"] = { query = "@function.outer", desc = "Swap with previous function" },
							["<leader>cps"] = { query = "@statement.outer", desc = "Swap with previous statement" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = { query = "@function.outer", desc = "Goto start of next function" },
							["]c"] = { query = "@class.outer", desc = "Goto start of next class" },
							["]i"] = { query = "@conditional.outer", desc = "Goto start of next conditional" },
							["]l"] = { query = "@loop.outer", desc = "Goto start of next loop" },
							["]b"] = { query = "@block.outer", desc = "Goto start of next block" },
							["]v"] = { query = "@call.outer", desc = "Goto start of next invocation" },
						},
						goto_next_end = {
							["]F"] = { query = "@function.outer", desc = "Goto end of next function" },
							["]C"] = { query = "@class.outer", desc = "Goto end of next class" },
							["]I"] = { query = "@conditional.outer", desc = "Goto end of next conditional" },
							["]L"] = { query = "@loop.outer", desc = "Goto end of next loop" },
							["]B"] = { query = "@block.outer", desc = "Goto end of next block" },
							["]V"] = { query = "@call.outer", desc = "Goto end of next invocation" },
						},
						goto_previous_start = {
							["[f"] = { query = "@function.outer", desc = "Goto start of previous function" },
							["[c"] = { query = "@class.outer", desc = "Goto start of previous class" },
							["[i"] = { query = "@conditional.outer", desc = "Goto start of previous conditional" },
							["[l"] = { query = "@loop.outer", desc = "Goto start of previous loop" },
							["[b"] = { query = "@block.outer", desc = "Goto start of previous block" },
							["[v"] = { query = "@call.outer", desc = "Goto end of previous invocation" },
						},
						goto_previous_end = {
							["[F"] = { query = "@function.outer", desc = "Goto end of previous function" },
							["[C"] = { query = "@class.outer", desc = "Goto end of previous class" },
							["[I"] = { query = "@conditional.outer", desc = "Goto end of previous conditional" },
							["[L"] = { query = "@loop.outer", desc = "Goto end of previous loop" },
							["[B"] = { query = "@block.outer", desc = "Goto end of previous block" },
							["[V"] = { query = "@call.outer", desc = "Goto end of previous invocation" },
						},
					},
				},
			})

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate", -- Update all parsers when nvim-treesitter is updated.
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true }, -- Syntax highlighting
				indent = { enable = true },
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"csv",
					"dockerfile",
					"diff",
					"gitignore",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"rust",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
