return {
	"m4xshen/smartcolumn.nvim",
	opts = {
		disabled_filetypes = { "help", "text" },
		scope = "line", -- file, window, line
		editorconfig = true,
		custom_colorcolumn = {
			go = { "100", "120" },
			python = { "80", "100" },
			lua = { "80", "100" },
			csharp = { "100", "120" },
			javascript = { "100", "120" },
			typescript = { "100", "120" },
			markdown = { "80" },
		},
	},
}
