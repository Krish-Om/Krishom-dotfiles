return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.1",
		auto_install = true,
		opts = {
			ensure_installed = {
				"python",
				"javascript",
				"typescript",
				"css",
				"gitignore",
				"graphql",
				"http",
				"json",
				"sql",
				"vim",
				"lua",
			},

			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
	},
}
