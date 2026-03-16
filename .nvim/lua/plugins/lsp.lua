return {
	{
		"onsails/lspkind-nvim",
	},
	{
		"hinell/lsp-timeout.nvim",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enalbe = {
				"copilot",

				exclude = {},
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = true,
	},

	{
		"aznhe21/actions-preview.nvim",
		config = true,
	},
	{
		"saghen/blink.compat",
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			-- "Kaiser-Yang/blink-cmp-avante",
			{ "fang2hou/blink-copilot" },
			{
				"mikavilpas/blink-ripgrep.nvim",
				version = "*", -- use the latest stable version
			},
		},

		opts = {
			keymap = {
				preset = "super-tab",

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",

					function(_)
						return require("sidekick").nes_jump_or_apply()
					end,
					function(_)
						return vim.lsp.inline_completion.get()
					end,
					"fallback",
				},

				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
			},
			snippets = { preset = "luasnip" },
			signature = { enabled = true },

			fuzzy = {
				implementation = "prefer_rust_with_warning",
				frecency = {
					enabled = true,
				},
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
			completion = {
				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before _and_ after the cursor
				-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
				keyword = { range = "full" },

				-- Disable auto brackets
				-- NOTE: some LSPs may add auto brackets themselves anyway
				accept = { auto_brackets = { enabled = false } },

				-- or set via a function

				menu = {
					-- Don't automatically show the completion menu
					auto_show = true,

					-- nvim-cmp style menu
				},

				-- Show documentation when selecting a completion item
				documentation = { auto_show = true, auto_show_delay_ms = 200 },

				-- Display a preview of the selected item on the current line
				ghost_text = { enabled = true },
			},

			sources = {

				default = { "copilot", "lsp", "lazydev", "snippets", "ripgrep", "buffer", "path" },
				compat = {},

				providers = {
					-- avante = {
					-- 	module = "blink-cmp-avante",
					-- 	name = "Avante",
					-- 	opts = {
					-- 		-- options for blink-cmp-avante
					-- 	},
					-- },
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						opts = {
							max_completions = 3,
							max_attempts = 4,
							kind_name = "Copilot", ---@type string | false
							kind_icon = " ", ---@type string | false
							kind_hl = false, ---@type string | false
							debounce = 200, ---@type integer | false
							auto_refresh = {
								backward = true,
								forward = true,
							},
						},
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						opts = {}, -- Passed to the source directly, varies by source

						--- NOTE: All of these options may be functions to get dynamic behavior
						--- See the type definitions for more information
						enabled = true, -- Whether or not to enable the provider
						async = true, -- Whether we should show the completions before this provider returns, without waiting for it
						timeout_ms = 100, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
						transform_items = nil, -- Function to transform the items before they're returned
						should_show_items = true, -- Whether or not to show the items
						max_items = 50, -- Maximum number of items to display in the menu
						min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
						-- If this provider returns 0 items, it will fallback to these providers.
						-- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
						fallbacks = {},
						score_offset = 0, -- Boost/penalize the score of the items
						override = nil, -- Override the source's functions
					},
					ripgrep = {
						name = "rg",
						module = "blink-ripgrep",
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {},
					},
				},
			},
		},
	},
	{
		"folke/sidekick.nvim",

		keys = {
			{
				"<leader>aa",
				function()
					-- You can filter by installed tools using { filter = { installed = true } }
					-- or just leave it empty to see all supported tools.
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end,
				mode = { "n", "v" },
				desc = "Select Sidekick Agent",
			},
		},
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "zellij",
					enabled = true,
				},
			},
		},
	},
}
