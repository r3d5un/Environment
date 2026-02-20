return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- latest release
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "Notes",
				path = "~/Documents/Notes",
				overrides = {
					notes_subdir = "Zettlekasten",
				},
			},
		},
		daily_notes = {
			folder = "dailies",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 1,
		},
		new_notes_location = "notes_subdir",
		ui = {
			enable = false,
		},
		attachments = {
			folder = "imgs",
		},
		note_id_func = function(title)
			local suffix = ""
			if title ~= nil then
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
	},
}
