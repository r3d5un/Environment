return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = { "tokyonight-night", "tokyonight-storm", "tokyonight-day", "tokyonight-moon", "default" },
			livePreview = true,
		})
	end,
}
