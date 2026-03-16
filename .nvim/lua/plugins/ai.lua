return {

	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
		opts = {
			auto_approve = false,
			extensions = {
				avante = {
					make_slash_commands = true,
				},
			},
		},
	},
}
