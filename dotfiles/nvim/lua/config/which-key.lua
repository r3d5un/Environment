local wk = require("which-key")

wk.add({
	{ "<leader>w", group = "Windows" },
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Document" },
	{ "<leader>h", group = "HTTP Client" },
	{ "<leader>n", group = "Obsidian [N]otes", mode = { "n", "v" } },
	{ "<leader>nf", group = "[F]ormat", mode = { "n", "v" } },
	{ "<leader>nl", group = "Note [L]inks" },
	{ "<leader>r", group = "Rename" },
	{ "<leader>s", group = "Search" },
	{ "<leader>w", group = "Workspace" },
	{ "<leader>x", group = "Diagnostics" },
	{ "<leader>b", group = "Buffers" },
})
