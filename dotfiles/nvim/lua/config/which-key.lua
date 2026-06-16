local wk = require("which-key")

wk.add({
	{ "<leader>w", group = "Windows" },
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Document" },
	{ "<leader>h", group = "HTTP Client" },
	{ "<leader>n", group = "[N]otes", mode = { "n", "v" } },
	{ "<leader>nf", group = "[F]ormat", mode = { "n", "v" } },
	{ "<leader>nl", group = "Note [L]inks" },
	{ "<leader>r", group = "Rename" },
	{ "<leader>s", group = "Search" },
	{ "<leader>w", group = "Workspace" },
	{ "<leader>x", group = "Diagnostics" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>nt", group = "[T]able" },
	{ "<leader>m", group = "[M]arkdown", mode = { "n", "v" } },
	{ "<leader>g", group = "[G]it" },
	{ "<leader>f", group = "[F]ile" },
	{ "<leader>nt", group = "[T]ables" },
	{ "<leader>m", group = "[M]arkdown" },
	{ "<leader>mf", group = "[F]ootnote" },
})
