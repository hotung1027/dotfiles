return {

	{
		"nvim-pack/nvim-spectre",
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		version = "^1.0.0",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},

	-- align
	{
		"junegunn/vim-easy-align",
	},
	-- filetype
	{
		"nathom/filetype.nvim",
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						h = "c",
						hpp = "cpp",
						c = "c",
					},
					complex = {
						["Dockerfile.*"] = "dockerfile",
						[".*urdf.*"] = "xml",
					},
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		lazy = true,

		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			sections = {
				lualine_x = {
					{
						function()
							-- Check if MCPHub is loaded
							if not vim.g.loaded_mcphub then
								return "󰐻 -"
							end

							local count = vim.g.mcphub_servers_count or 0
							local status = vim.g.mcphub_status or "stopped"
							local executing = vim.g.mcphub_executing

							-- Show "-" when stopped
							if status == "stopped" then
								return "󰐻 -"
							end

							-- Show spinner when executing, starting, or restarting
							if executing or status == "starting" or status == "restarting" then
								local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
								local frame = math.floor(vim.loop.now() / 100) % #frames + 1
								return "󰐻 " .. frames[frame]
							end

							return "󰐻 " .. count
						end,
						color = function()
							if not vim.g.loaded_mcphub then
								return { fg = "#6c7086" } -- Gray for not loaded
							end

							local status = vim.g.mcphub_status or "stopped"
							if status == "ready" or status == "restarted" then
								return { fg = "#50fa7b" } -- Green for connected
							elseif status == "starting" or status == "restarting" then
								return { fg = "#ffb86c" } -- Orange for connecting
							else
								return { fg = "#ff5555" } -- Red for error/stopped
							end
						end,
					},
				},
			},
		},
	},

	{
		"folke/snacks.nvim",
		optional = true,
		opts = {
			picker = {
				enable = true,
				actions = {
					sidekick_send = function(...)
						return require("sidekick.cli.picker.snacks").send(...)
					end,
				},
				win = {
					input = {
						keys = {
							["<a-a>"] = {
								"sidekick_send",
								mode = { "n", "i" },
							},
						},
					},
				},
			},
			bigfile = { enable = true },
			indent = { enable = true },
			dim = { enable = true },
		},
	},
	{
		"folke/trouble.nvim",
		opts = {},
		branch = "release-please--branches--main",
	},

	-- undo
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<C-u>", mode = { "n", "x", "o" }, "<cmd>UndotreeToggle<CR>", desc = "Open Undo Tree" },
		},
	},
}
